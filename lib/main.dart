import 'package:alarmloop/alarm_cubit/alarm_updated_cubit.dart';
import 'package:alarmloop/cubit/day_selection_cubit.dart';
import 'package:alarmloop/ui/home/home_screen.dart';
import 'package:alarmloop/ui/home/splash_screen.dart';
import 'package:alarmloop/utils/routes.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'alarm_cubit/alarm_edited_cubit.dart';
import 'cubit/alarm_cubit.dart';
import 'cubit/sounds_cubut.dart';
import 'ui/home/updated_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

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
