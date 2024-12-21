import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting

class ContractDetails extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API

  const ContractDetails({super.key, required this.contractData});

  @override
  State<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  String formatDate(String dateString) {
    // Parse the timestamp and format it as "day month year"
    final DateTime date = DateTime.parse(dateString);
    return DateFormat("dd MMMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    final contract = widget.contractData;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Contract Details",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8234C5),
            ),
          ),
          SizedBox(height: 16.0),

          // Details Section
          _buildDetailItem("Project Name:", contract['project_name']),
          _buildDetailItem("Project Description:", contract['project_description']),
          _buildDetailItem("Project Deadline:", formatDate(contract['project_deadline'])),
          _buildDetailItem("Contract Created Date:", formatDate(contract['contract_created'])),

          // Dropdown for Detailed Project Information
          ExpansionTile(
            title: Text(
              "Project Details",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8234C5),
              ),
            ),
            iconColor: Color(0xFF8234C5),
            children: [
              _buildDetailItem(
                  "Purpose: ", contract['map_data'][0]["What is the purpose of the website?"]),
              _buildDetailItem(
                  "Pages: ", contract['map_data'][1]["How many pages?"]),
              _buildDetailItem(
                  "Theme: ", contract['map_data'][2]["Enter your theme of website?"]),
              _buildDetailItem(
                  "Additional Details: ",
                  contract['map_data'][3]["Are there any specific third-party services or APIs that need to be integrated with the site?"]),
              _buildDetailItem("Payments to Trustopay: ", "\$${contract['project_amount']}"),
            ],
          ),
        ],
      ),
    );
  }

  // Widget to build individual detail items
  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/