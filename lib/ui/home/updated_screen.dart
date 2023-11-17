import 'package:alarmloop/model/sound_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../alarm_cubit/alarm_updated_state.dart';
import '../../cubit/alarm_cubit.dart';
import '../../model/alarm_model.dart';
import '../../utils/demo_data.dart';
import '../../widgets/cards/alarm_card.dart';

class UpdatedHomeScreen extends StatefulWidget {
  static String routeName = "/update-home";
  const UpdatedHomeScreen({Key? key}) : super(key: key);

  @override
  State<UpdatedHomeScreen> createState() => _UpdatedHomeScreenState();
}

class _UpdatedHomeScreenState extends State<UpdatedHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 246, 246, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.red,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title: const Text('Set Alarm'),
          centerTitle: true,
          elevation: 1,
          foregroundColor: Colors.red,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //     },
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
        ),
      body: BlocBuilder<UpdatedAlarmsCubit, UpdatedAlarmsState>(
        builder: (context, state) {
          if (state.alarms.isEmpty) {
            // Load alarms when the widget is first built
            context.read<UpdatedAlarmsCubit>().loadAlarms();
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: state.alarms.length,
            itemBuilder: (context, index) {
              return AlarmCard(alarm: state.alarms[index]);
            },
          );
        },
      ),
    );
  }
}
