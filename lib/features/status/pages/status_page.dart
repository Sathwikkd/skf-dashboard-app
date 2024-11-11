import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/common/loader/loader.dart';
import 'package:skf_project/features/status/bloc/status_bloc.dart';
import 'package:skf_project/features/status/widgets/status_page_card.dart';

class StatusPage extends StatefulWidget {
  final String drierId;
  final String plcId;
  const StatusPage({
    super.key,
    required this.drierId,
    required this.plcId,
  });

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
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StatusBloc>(context).add(
      FetchStatusDataEvent(
        drierId: widget.drierId,
        plcId: widget.plcId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatusBloc, StatusState>(
      listener: (context, state) {
        if (state is FetchStatusDataSuccessState) {
          setState(() {
            isConnected = true;
            // Update `blowerTS` only if a valid value is received
            if (state.data.containsKey('st_bl_trp') &&
                state.data['st_bl_trp'] != null) {
              blowerTS = state.data['st_bl_trp'];
            }

            // Update `elevatorTS` only if a valid value is received
            if (state.data.containsKey('st_el_trp') &&
                state.data['st_el_trp'] != null) {
              elevatorTS = state.data['st_el_trp'];
            }

            // Update `rotorTS` only if a valid value is received
            if (state.data.containsKey('st_rt_trp') &&
                state.data['st_rt_trp'] != null) {
              rotorTS = state.data['st_rt_trp'];
            }

            // Update `blowerRS` only if a valid value is received
            if (state.data.containsKey('st_bl_rn') &&
                state.data['st_bl_rn'] != null) {
              blowerRS = state.data['st_bl_rn'];
            }

            // Update `elevatorRS` only if a valid value is received
            if (state.data.containsKey('st_el_rn') &&
                state.data['st_el_rn'] != null) {
              elevatorRS = state.data['st_el_rn'];
            }

            // Update `rotorRS` only if a valid value is received
            if (state.data.containsKey('st_rt_rn') &&
                state.data['st_rt_rn'] != null) {
              rotorRS = state.data['st_rt_rn'];
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade400,
        appBar: AppBar(
          actions: [
            Icon(
              !isConnected
                  ? Icons.network_wifi_1_bar_sharp
                  : Icons.network_wifi_sharp,
              color: !isConnected ? Colors.red : Colors.green,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<StatusBloc>(context).add(
                  FetchStatusDataEvent(
                    drierId: widget.drierId,
                    plcId: widget.plcId,
                  ),
                );
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
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
          child: BlocBuilder<StatusBloc, StatusState>(
            builder: (context, state) {
              if (state is FetchStatusDataFailedState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Something Went Wrong...",
                          style: GoogleFonts.nunito(
                            color: Colors.grey.shade500,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<StatusBloc>(context).add(
                            FetchStatusDataEvent(
                              drierId: widget.drierId,
                              plcId: widget.plcId,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(
                          "Retry",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              if(state is FetchStatusDataLoadingState){
                return const Center(
                  child: Loader(),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/status.jpeg",
                          width: 250,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
