import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusPageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  const StatusPageCard(
      {super.key,
      required this.title,
      required this.subtitle,
      this.status = "81"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-6, 6),
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 1,
          ),
          const BoxShadow(
            offset: Offset(6, -6),
            color: Colors.white,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        subtitle: Text(
          subtitle,
          style: GoogleFonts.nunito(
              color: Colors.grey, fontWeight: FontWeight.w600),
        ),
        title: Text(
          title,
          style: GoogleFonts.nunito(
            color: Colors.grey.shade700,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          width: 50,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: status == "81"
                ? const Color.fromARGB(126, 244, 67, 79)
                : const Color.fromARGB(133, 76, 175, 79),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 3),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: status == "0" ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Text(
                status == "81" ? "OFF" : "ON",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
