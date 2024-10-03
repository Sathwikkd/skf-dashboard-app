import 'package:flutter/material.dart';
import 'package:skf_project/components/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLine extends StatelessWidget {
  final isFirst;
  final isLast;
  final isPast;
  final eventcard;
  final Function? onStepComplete;

  const MyTimeLine({super.key,
  required this.isFirst,
  required this.isLast,
  required this.isPast,
  required this.eventcard,
  this.onStepComplete
  });

  @override
  Widget build(BuildContext context) {

      if (isLast && isPast && onStepComplete != null) {
      onStepComplete!();
      }
    return SizedBox(height: 100,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        //line decoration
        beforeLineStyle: LineStyle(color:isPast? Colors.blue : Colors.blue.shade200),
        //icon styling
        indicatorStyle: IndicatorStyle(
          width: 38,
          color:isPast ? Colors.blue : Colors.blue.shade200,
          iconStyle: IconStyle(iconData: Icons.done,
          color:isPast ? Colors.white : Colors.blue.shade200),
        ),
      
        //event cards
        endChild: EventCard(
          isPast: isPast,
          child: eventcard,
        ),
      ),
    );
  }
}