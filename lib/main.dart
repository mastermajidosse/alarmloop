import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/alarm_cubit.dart';
import 'cubit/notification_cubit.dart';
import 'cubit/set_alarm_time_cubit.dart';
import 'cubit/sounds_cubut.dart';
import 'ui/home/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'utils/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  tz.initializeTimeZones();
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 360),
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4286, 683.4286),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AlarmCubit>(
                create: (BuildContext context) => AlarmCubit(),
              ),
              BlocProvider<SoundsCubit>(
                create: (BuildContext context) => SoundsCubit(),
              ),
             BlocProvider<NotificationCubit>(
                create: (BuildContext context) => NotificationCubit(),
              ),
              BlocProvider<SetAlarmTimeCubit>(
                create: (BuildContext context) => SetAlarmTimeCubit(),
              ),
            ],
            child: MaterialApp(
              title: 'Alarm loop',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              initialRoute: SplashScreen.routeName,
              routes: routes,
              // home:AlarmScreen(),
            ),
          );
        });
  }
}
// class NotificationController {

//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here
//   }

//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here

//     // Navigate into pages, avoiding to open the notification details page over another details page already opened
//   }
// }