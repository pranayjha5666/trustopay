import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopArea extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  const TopArea({super.key, required this.contractData});

  @override
  State<TopArea> createState() => _TopAreaState();
}

class _TopAreaState extends State<TopArea> {
  @override
  Widget build(BuildContext context) {
    final contract = widget.contractData; // Extract contract data for easier access
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Name
        Center(
          child: Text(
            'Project: ${contract['project_name']}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8234C5),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        // Services Name
        Center(
          child: Text(
            'Service: ${contract['services']}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(height: 24.0),
        // Buyer Seller Area
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Buyer Column
            Column(
              children: [
                // Circular Icon for Buyer
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF8234C5).withOpacity(0.1),
                  child: Icon(Icons.person,
                      size: 50, color: Color(0xFF8234C5)),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${contract['buyer']}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Buyer',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            // Middle Icon
            Icon(
              Icons.handshake_outlined,
              size: 100,
              color: Color(0xFF8234C5),
            ),
            // Seller Column
            Column(
              children: [
                // Circular Icon for Seller
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF8234C5).withOpacity(0.1),
                  child: Icon(Icons.person,
                      size: 50, color: Color(0xFF8234C5)),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${contract['seller']}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Seller',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/