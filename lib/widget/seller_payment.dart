import 'package:flutter/material.dart';

class ContractPage extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  final VoidCallback onPaymentCompleted; // Callback to notify when payment is completed

  const ContractPage({Key? key, required this.onPaymentCompleted, required this.contractData}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {

  int currentStep = 0; // Tracks the current step of the stepper
  bool isPaymentCompleted = false; // Tracks if payment for the final milestone is completed
  bool isStepperVisible = true; // Determines if the stepper is visible or replaced with a details title

  @override


  // Function to show the confirmation dialog for each step
  Future<void> showConfirmationDialog(double amount, bool isLastStep) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to send $amount to the seller?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  if (isLastStep) {
                    widget.onPaymentCompleted(); // Notify payment completion
                    isStepperVisible = false; // Hide the stepper after confirmation
                  } else {
                    if (currentStep < widget.contractData['milestones'].length - 1) {
                      currentStep++;
                    }
                  }
                });
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    if (widget.contractData == null || widget.contractData['milestones'] == null || widget.contractData['milestones'].isEmpty) {
      return Center(child: Text('No milestone data available.'));
    }

    List milestones = widget.contractData['milestones'];

    return Column(
      children: [
        isStepperVisible
            ? Stepper(
          currentStep: currentStep,
          onStepTapped: (step) {
            if (!isPaymentCompleted) {
              setState(() {
                currentStep = step;
              });
            }
          },
          onStepContinue: () {
            if (!isPaymentCompleted) {
              double amount = (milestones[currentStep]['amount'] is int)
                  ? (milestones[currentStep]['amount'] as int).toDouble()
                  : milestones[currentStep]['amount'] ?? 0.0;
              bool isLastStep = currentStep == milestones.length - 1;
              showConfirmationDialog(amount, isLastStep);
            }
          },
          onStepCancel: () {
            if (!isPaymentCompleted && currentStep > 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          steps: milestones.map<Step>((milestone) {
            return Step(

              title: Text(milestone['title'] ?? 'No Title'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentStep != milestones.length - 1 || !isPaymentCompleted)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ${milestone['amount']}'),
                        Text('Due Date: ${milestone['due_date']}'),
                        SizedBox(height: 10),
                        Text('Description:'),
                        Text(milestone['description'] ?? 'No Description'),
                      ],
                    ),
                ],
              ),
              isActive: currentStep == milestones.indexOf(milestone),
              state: currentStep == milestones.indexOf(milestone) && isPaymentCompleted
                  ? StepState.complete
                  : StepState.indexed, // Mark the step as complete after payment
            );
          }).toList(),
        )
            : Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                        //Column of list os title after the final conformation
                        children: milestones.map<Widget>((milestone) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF8234C5)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        milestone['title'] ?? 'No Title',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
                        }).toList(),
                      ),
            ),
      ],
    );
  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/