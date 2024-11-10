import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/common/loader/loader.dart';
import 'package:skf_project/core/common/widgets/indications/snackbar.dart';
import 'package:skf_project/features/auth/bloc/auth_bloc.dart';
import 'package:skf_project/features/drier_selection/bloc/drier_bloc.dart';
import 'package:skf_project/features/drier_selection/widgets/drier_selection_card.dart';

class DrierSelectionPage extends StatefulWidget {
  const DrierSelectionPage({super.key});

  @override
  State<DrierSelectionPage> createState() => _DrierSelectionPageState();
}

class _DrierSelectionPageState extends State<DrierSelectionPage> {
  
  @override
  void initState() {
    BlocProvider.of<DrierBloc>(context).add(
      FetchAllDriersEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(
              AuthLogoutEvent(),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade400,
        automaticallyImplyLeading: false,
        title: Text(
          "Select Drier",
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccessState) {
            Navigator.pushReplacementNamed(context, "/login");
          } else if (state is AuthLogouteFailedState) {
            Snackbar.showSnackbar(
              message: state.message,
              leadingIcon: Icons.error,
              context: context,
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.grey.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: BlocBuilder<DrierBloc, DrierState>(
                  builder: (context, state) {
                    if (state is DrierFetchSuccessState) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/home",
                                    arguments: Arguments(
                                      drierId: state.data[index]['drier_id'],
                                      plcId: state.data[index]['plc_id'],
                                    ),
                                  );
                                },
                                child: DrierSelectionCard(
                                  drierName: state.data[index]['label'],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                        itemCount: state.data.length,
                      );
                    }
                    if (state is DrierFetchFailedState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              state.errCode == 1
                                  ? Icons.not_interested_rounded
                                  : state.errCode == 2
                                      ? Icons.no_accounts
                                      : Icons.no_cell_rounded,
                              size: 60,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.message,
                              style: GoogleFonts.nunito(
                                  color: Colors.grey.shade600,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<DrierBloc>(context).add(
                                  FetchAllDriersEvent(),
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
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is DrierFetchLoadingState) {
                      return const Center(child: Loader());
                    }
                    return const Center(child: Loader());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Arguments {
  final String drierId;
  final String plcId;
  Arguments({required this.drierId, required this.plcId});
}
