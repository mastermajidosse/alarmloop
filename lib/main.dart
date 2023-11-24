import 'package:alarmloop/alarm_cubit/alarm_updated_cubit.dart';
import 'package:alarmloop/cubit/day_selection_cubit.dart';
import 'package:alarmloop/ui/home/splash_screen.dart';
import 'package:alarmloop/utils/routes.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'alarm_cubit/alarm_edited_cubit.dart';
import 'alarm_cubit/update/update_alarm_cubit.dart';
import 'cubit/alarm_cubit.dart';
import 'cubit/sounds_cubut.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 360),
      builder: (conext, child) => MyApp(),
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
              BlocProvider<DaySelectionCubit>(
                create: (BuildContext context) => DaySelectionCubit(),
              ),
              BlocProvider<SoundsCubit>(
                create: (BuildContext context) => SoundsCubit(),
              ),
              BlocProvider<UpdatedAlarmsCubit>(
                create: (BuildContext context) => UpdatedAlarmsCubit(),
              ),
              BlocProvider<EditAlarmCubit>(
                create: (BuildContext context) => EditAlarmCubit(),
              ),
              BlocProvider<AlarmsCubitUpdated>(
                create: (BuildContext context) => AlarmsCubitUpdated(),
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
            ),
          );
        });
  }
}
