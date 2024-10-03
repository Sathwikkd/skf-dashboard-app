import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/home/pages/recipe.dart';
import 'package:skf_project/features/home/pages/temperature_status.dart';
import 'package:skf_project/features/home/pages/valve_status.dart';
import 'package:skf_project/features/home/widgets/custom_home_page_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          _startingRow(),
          _secondRowCards(),
          _lastSection(),
        ],
      ),
    );
  }

  Widget _startingRow() {
    return SizedBox(
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
                title: "Total Devices",
                icon: Icons.electrical_services_rounded,
                iconSize: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipeTemperature()));
                },
                child: const CustomHomePageCard(
                  title: "Active Devices",
                  icon: Icons.electric_bolt_rounded,
                  iconSize: 60,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomHomePageCard(
                title: "Recipe Temp",
                icon: Icons.thermostat,
                iconSize: 60,
              ),
              CustomHomePageCard(
                title: "Status",
                icon: Icons.done_all_rounded,
                iconSize: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _lastSection() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomKeys(
                  Icons.history, "History", Icons.arrow_forward_ios_rounded),
              _bottomKeys(Icons.add_chart_rounded, "Data Graphs",
                  Icons.arrow_forward_ios_rounded),
              _bottomKeys(
                Icons.info,
                "Help and Support",
                Icons.arrow_forward_ios_rounded,
              )
            ],
          ),
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
