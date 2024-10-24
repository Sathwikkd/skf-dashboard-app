import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/features/status/bloc/status_bloc.dart';
import 'package:skf_project/features/status/widgets/status_page_card.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String blowerTS = "0";
  String elevatorTS = "0";
  String rotorTS = "0";
  String blowerRS = "0";
  String elevatorRS = "0";
  String rotorRS = "0";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatusBloc>(context).add(FetchStatusDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatusBloc, StatusState>(
      listener: (context, state) {
        if (state is FetchStatusDataSuccessState) {
          if (state.data['mt'] == "10") {
            setState(() {
              blowerTS = state.data['st'] ?? "81";
            });
          } else if (state.data['mt'] == "11") {
            setState(() {
              elevatorTS = state.data['st'] ?? "81";
            });
          } else if (state.data['mt'] == "12") {
            setState(() {
              rotorTS = state.data['st'] ?? "81";
            });
          } else if (state.data['mt'] == "13") {
            setState(() {
              blowerRS = state.data['st'] ?? "81";
            });
          } else if (state.data['mt'] == "14") {
            setState(() {
              elevatorRS = state.data['st'] ?? "81";
            });
          } else if (state.data['mt'] == "15") {
            setState(() {
              rotorRS = state.data['st'] ?? "81";
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade400,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<StatusBloc>(context).add(StopStatusStreamEvent());
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
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
                  StatusPageCard(
                    title: "Blower Trip Status",
                    subtitle: "Represents blower status",
                    status: blowerTS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatusPageCard(
                    title: "Elevator Trip Status",
                    subtitle: "Represents elevator status",
                    status: elevatorTS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatusPageCard(
                    title: "Rotor Trip Status",
                    subtitle: "Represents rotor status",
                    status: rotorTS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatusPageCard(
                    title: "Blower Run Status",
                    subtitle: "Represents blower status",
                    status: blowerRS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatusPageCard(
                    title: "Elevator Run Status",
                    subtitle: "Represents elevator status",
                    status: elevatorRS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatusPageCard(
                    title: "Rotor Run Status",
                    subtitle: "Represents rotor status",
                    status: rotorRS,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
