import 'package:calendar/screens/Calendar/components/CalendarBody.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Calendar extends StatelessWidget {
  static String route = 'Calendar';
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarBody();
  }
}
