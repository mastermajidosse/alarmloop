import 'package:alarmloop/model/sound_model.dart';
import 'package:alarmloop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../alarm_cubit/alarm_updated_state.dart';
import '../../cubit/alarm_cubit.dart';
import '../../model/alarm.dart';
import '../../model/alarm_model.dart';
import '../../utils/demo_data.dart';
import '../../widgets/cards/alarm_card.dart';
import '../edit/updated_edited_screen.dart';

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
      backgroundColor: Style.whiteClr,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Style.blackClr,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        title: const Text('Alarm'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<UpdatedAlarmsCubit, UpdatedAlarmsState>(
        builder: (context, state) {
          if (state.alarms.isEmpty) {
            context.read<UpdatedAlarmsCubit>().loadAlarms();
          }
          return state.alarms.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: state.alarms.length,
                  itemBuilder: (context, index) {
                    return AlarmCard(alarm: state.alarms[index]);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.greyColor,
        onPressed: () async {
          // Create a new alarm (you can replace this with your own logic to create alarms)
          Alarm newAlarm = Alarm(
              selectedDays: 'F T T M W S',
              isSwitched: false,
              hour: 10,
              isAM: true,
              title: 'Alarm',
              minute: 10,
              period: '10');

          // Add the new alarm to the list and save it to SharedPreferences
          await context.read<UpdatedAlarmsCubit>().addAlarm(newAlarm);
        },
        child: Icon(Icons.alarm_add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No alarms yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle the button press to add a new alarm
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatedEditAlarmForm(),
                ),
              );
            },
            child: Text('Add Alarm'),
          ),
        ],
      ),
    );
  }
}
