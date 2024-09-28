import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHomePageCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;
  const CustomHomePageCard({super.key, required this.title , required this.icon , required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade400,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade500,
            offset: const Offset(-4, 4),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.blue.shade300,
            offset: const Offset(4, -4),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                size: iconSize,
                color: Colors.white,
              ),
              Text("5" , style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
