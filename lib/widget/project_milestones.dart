// project_milestones.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/fetchdata.dart';
import 'seller_payment.dart';

class ProjectMilestones extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  const ProjectMilestones({super.key, required this.contractData});

  @override
  State<ProjectMilestones> createState() => _ProjectMilestonesState();
}

class _ProjectMilestonesState extends State<ProjectMilestones> {
  // Milestone states
  bool invitationAccepted = false;
  bool paymentMade = false;
  String? paymentId;
  bool sellerStartedWorking = false;
  bool sellerDeliveredProject = false;
  bool buyerConfirmedDelivery = false;
  bool paymentReleased = false;
  int currentActiveStep = 0; // Track the current active step

  // Stepper miles
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Milestones",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8234C5),
            ),
          ),
          const SizedBox(height: 16.0),

          // Step 1: Invitation Accepted by User
          _buildStep(
            title: "Invitation Accepted by User",
            isComplete: invitationAccepted,
            onComplete: () {
              setState(() {
                invitationAccepted = true;
              });
            },
          ),

          // Step 2: Payment Made to Trustopay
          if (invitationAccepted)
            _buildStep(
              title: "Payment Made to Trustopay",
              isComplete: paymentMade,
              onComplete: () {
                setState(() {
                  paymentMade = true;
                  paymentId = widget.contractData['payments_to_trustopay'][0]["payment_id"];
                });
              },
            ),
          if (paymentMade && paymentId != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Payment ID: $paymentId",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
              ),
            ),

          // Step 3: Seller Started Working
          if (paymentMade)
            _buildStep(
              title: "Seller Started Working",
              isComplete: sellerStartedWorking,
              onComplete: () {
                setState(() {
                  sellerStartedWorking = true;
                });
              },
            ),

          // Step 4: Display Contract Page for Payment Confirmation
          if (sellerStartedWorking)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  "Contract & Payment Confirmation",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8234C5),
                  ),
                ),
                const SizedBox(height: 8.0),
                // Include the contract page logic here
                ContractPage(
                  contractData: widget.contractData,  // Pass the contract data for the second step (Development Phase)

                  onPaymentCompleted: () {
                    setState(() {
                      sellerDeliveredProject = true;  // Move to the next step after payment is completed
                    });
                  },
                ),
              ],
            ),

          // Step 5: Seller Delivered Project
          if (sellerDeliveredProject)
            _buildStep(
              title: "Seller Delivered Project",
              isComplete: true,
              onComplete: () {},
            ),

          // Step 6: Buyer Confirms Delivery
          if (sellerDeliveredProject)
            _buildStep(
              title: "Buyer Confirms Delivery",
              isComplete: buyerConfirmedDelivery,
              onComplete: () {
                setState(() {
                  buyerConfirmedDelivery = true;
                });
              },
            ),

          // Step 7: Payment Released to Seller
          if (buyerConfirmedDelivery)
            _buildStep(
              title: "Payment Released to Seller",
              isComplete: paymentReleased,
              onComplete: () {
                setState(() {
                  paymentReleased = true;
                });
              },
            ),

          // Step 8:Final Conformation icon
          if (paymentReleased)
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      'All payments have been completed successfully!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Steps for Project Milestones
  Widget _buildStep({
    required String title,
    required bool isComplete,
    required VoidCallback onComplete,
  }) {
    return ListTile(
      leading: isComplete
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.radio_button_unchecked, color: Colors.grey),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: !isComplete
          ? ElevatedButton(
        onPressed: onComplete,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8234C5),
        ),
        child: Text(
          "Mark as Done",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
      )
          : null,
    );
  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/