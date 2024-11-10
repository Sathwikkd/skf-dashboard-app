import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskElement extends StatelessWidget {
  final bool completed;
  final String taskName;
  const TaskElement({super.key , required this.completed , required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
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
        leading: Icon(
          Icons.done_all_rounded,
          color:completed ? Colors.green: Colors.grey,
        ),
        title: Text(
          taskName,
          style: GoogleFonts.nunito(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          completed?"Complete": "Pending",
          style: GoogleFonts.nunito(
              color:completed ? Colors.green : Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
