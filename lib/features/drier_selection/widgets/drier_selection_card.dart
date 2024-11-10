import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrierSelectionCard extends StatelessWidget {
  final String drierName;
  const DrierSelectionCard({super.key , required this.drierName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-4, 4),
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
          ),
          const BoxShadow(
            offset: Offset(5, -5),
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Center(
        child: ListTile(
          leading:const Icon(Icons.precision_manufacturing_sharp  , size: 30,),
          title: Text(
            drierName,
            style: GoogleFonts.nunito(
              color: Colors.grey.shade800,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // subtitle: Text(drierId , style: GoogleFonts.nunito(
          //   color: Colors.grey.shade500,
          //   fontWeight: FontWeight.bold,
          // ),),
          trailing:const Icon(Icons.arrow_outward_rounded , size: 30,),
        ),
      ),
    );
  }
}
