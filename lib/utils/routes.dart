import 'package:alarmloop/ui/choose_alarm/choose_alarm_screen.dart';
import 'package:alarmloop/ui/edit/edit_screen.dart';
import 'package:alarmloop/ui/home/home_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  EditScreen.routeName: (context) => const EditScreen(),
  ChooseAlarmScreen.routeName: (context) => const ChooseAlarmScreen(),
};
