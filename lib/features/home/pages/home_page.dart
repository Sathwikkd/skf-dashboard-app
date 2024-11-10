import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/drier_selection/pages/drier_selection_page.dart';
import 'package:skf_project/features/home/widgets/custom_home_page_card.dart';

class HomePage extends StatefulWidget {
  final String drierId;
  final String plcId;
  const HomePage({super.key, required this.drierId, required this.plcId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _startingRow(),
            _secondRowCards(),
            _lastSection(),
          ],
        ),
      ),
    );
  }

  Widget _startingRow() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/logo.png"),
          ],
        ),
      ),
    );
  }

  Widget _secondRowCards() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomHomePageCard(
                title: "Devices",
                icon: Icons.electrical_services_rounded,
                iconSize: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/temp");
                },
                child: const CustomHomePageCard(
                  title: "Realtime",
                  icon: Icons.electric_bolt_rounded,
                  iconSize: 40,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/recipe",
                    arguments: Arguments(
                      drierId: widget.drierId,
                      plcId: widget.plcId,
                    ),
                  );
                },
                child: const CustomHomePageCard(
                  title: "Recipe",
                  icon: Icons.thermostat,
                  iconSize: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/status");
                },
                child: const CustomHomePageCard(
                  title: "Status",
                  icon: Icons.done_all_rounded,
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _lastSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: MediaQuery.of(context).size.height - 480,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomKeys(
              Icons.info,
              "About",
              Icons.arrow_forward_ios_rounded,
            ),
            _bottomKeys(
              Icons.feedback,
              "Feedback",
              Icons.arrow_forward_ios_rounded,
            ),
            _bottomKeys(
              Icons.code,
              "Developed By",
              Icons.arrow_forward_ios_rounded,
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomKeys(IconData leading, String title, IconData trailing) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(-4, 4),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(4, -4),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  leading,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(
              trailing,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
