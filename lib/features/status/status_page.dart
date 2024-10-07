import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/status/widgets/status_page_card.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        surfaceTintColor: Colors.blue.shade400,
        backgroundColor: Colors.blue.shade400,
        title: Text(
          "Status Page",
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/blower.png",
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Status",
                  style: GoogleFonts.nunito(
                    color: Colors.grey.shade700,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const StatusPageCard(
                  title: "Blower",
                  subtitle: "Represents blower status",
                ),
                const SizedBox(
                  height: 20,
                ),
                const StatusPageCard(
                  title: "Elevator",
                  subtitle: "Represents elevator status",
                ),
                const SizedBox(
                  height: 20,
                ),
                const  StatusPageCard(
                  title: "Rotor",
                  subtitle: "Represents rotor status",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
