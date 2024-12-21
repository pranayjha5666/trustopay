// home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trustopay/widget/contract_details.dart';
import 'package:trustopay/widget/project_milestones.dart';
import 'package:trustopay/widget/top_area.dart';
import 'Services/fetchdata.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isError = false;
  dynamic contractData;

  @override
  void initState() {
    super.initState();
    fetchContractData();
    Future.delayed(Duration(seconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  // Fetch contract data asynchronously from the API
  Future<void> fetchContractData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    var fetch = Fetch();
    var data = await fetch.fetchContractData();

    setState(() {
      isLoading = false;
      if (data != null) {
        contractData = data;
      } else {
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while fetching data
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // Show an error message if data fetching fails
    if (isError) {
      return Center(child: Text('Error loading contract data.'));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/tp_logo.svg',
                  height: 30,
                ),
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  text: 'Freelancing ',
                  style: TextStyle(
                    color: Color(0xFF8234C5),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Contract',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: contractData != null
          ? SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Displays buyer and seller information
              TopArea(contractData: contractData),
              const Divider(),
              // Displays detailed information about the contract and the projects
              ContractDetails(contractData: contractData),
              Divider(),
              // Displays project milestones and payment details
              ProjectMilestones(contractData: contractData),
            ],
          ),
        ),
      )
          : Center(
        child: Text(
          "No Data Available",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );

  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/