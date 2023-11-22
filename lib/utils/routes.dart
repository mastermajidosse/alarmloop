import 'package:alarmloop/ui/choose_alarm/choose_alarm_screen.dart';
import 'package:alarmloop/ui/edit/edit_screen.dart';
import 'package:alarmloop/ui/home/home_screen.dart';
import 'package:alarmloop/ui/home/splash_screen.dart';
import 'package:flutter/widgets.dart';

import '../ui/add_alarm/add_new_alarm.dart';
import '../ui/edit/updated_edited_screen.dart';
import '../ui/home/updated_home_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  SplashScreen.routeName: (context) =>  SplashScreen(),
  UpdatedHomeScreen.routeName: (context) => const UpdatedHomeScreen(),
  EditScreen.routeName: (context) => const EditScreen(),
  ChooseAlarmScreen.routeName: (context) => const ChooseAlarmScreen(),
  UpdatedEditAlarmForm.routeName: (context) =>  UpdatedEditAlarmForm(),
  AddNewAlarmScreen.routeName: (context) =>  AddNewAlarmScreen(),
};
