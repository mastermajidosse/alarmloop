import 'package:alarmloop/model/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/alarm_edited_cubit.dart';
import '../../alarm_cubit/alarm_edited_state.dart';
import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../alarm_cubit/update/update_alarm_cubit.dart';
import '../../alarm_cubit/update/update_alarm_state.dart';
import '../../cubit/alarm_cubit.dart';
import '../../cubit/day_selection_cubit.dart';
import '../../cubit/day_selection_state.dart';
import '../../model/alarm.dart';
import '../../model/args_model.dart';
import '../../utils/style.dart';
import '../../widgets/custom_card.dart';
import '../choose_alarm/choose_alarm_screen.dart';

// ignore: must_be_immutable
class UpdatedEditAlarmForm extends StatelessWidget {
  static String routeName = "/update-edited-screen";
  



  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    AlarmModel alarm = bloc.state.alarms[bloc.state.indexSelectedAlarm];
    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
      child: Scaffold(
        backgroundColor: Style.whiteClr,
        appBar: AppBar(
          leading: BackButton(
            color: Style.blackClr,
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Style.blackClr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title: Text(
            'Set Alarm',
            style: Style.textStyleBtn(),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) => SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !alarm.isAm
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: Icon(
                          Icons.dark_mode_outlined,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      )
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: Icon(
                          Icons.wb_sunny,
                          size: 30.0,
                          color: Colors.orange,
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => bloc.selectAlarmTime(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: BlocBuilder<AlarmCubit, AlarmState>(
                              builder: (context, state) {
                                return Text(
                                  alarm.ringTime,
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            bloc.setIsAm() ? 'AM' : 'PM',
                            style: Style.textStyleBtn(),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                Image.asset('assets/images/horloge.png'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ChooseAlarmScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.music_note_rounded,
                        color: Colors.red,
                      ),
                      BlocBuilder<AlarmCubit, AlarmState>(
                          builder: (context, state) {
                        return Text(
                          alarm.sound.name,
                          style: TextStyle(fontSize: 20.sp),
                        );
                      }),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(),
                ),
                // Dynamic days selection
                BlocBuilder<DaySelectionCubit, DaySelectionState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        7,
                        (index) => DayCard(
                          isHome: false,
                          dayIndex: index,
                          alarmIndex: alarm.id,
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(alarm.isAm
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined),
                          onPressed: () {
                            bloc.setIsAm()
                                ? bloc.turnOffSwitch(alarm.id)
                                : bloc.turnOnSwitch(alarm.id);
                          },
                        ),
                        Text(
                          bloc.setIsAm() ? 'AM' : 'PM',
                          style: Style.textStyleBtn(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Off',
                          style: Style.textStyleBtn(),
                        ),
                        Switch(
                          value: alarm.isEnabled,
                          onChanged: (value) {
                            if (value == true) {
                              bloc.turnOnCheckBox(alarm.id);
                            } else {
                              bloc.turnOffCheckBox(alarm.id);
                            }
                            print("isEnabled$value");
                          },
                          activeTrackColor: Style.blackClr,
                          activeColor: Style.greenClr,
                          inactiveThumbColor: Style.blackClr,
                          inactiveTrackColor: Style.greyColor,
                        ),
                        Text(
                          'On',
                          style: Style.textStyleBtn(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Style.whiteClr),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Style.blackClr),
                    ),
                    foregroundColor: MaterialStateProperty.all(Style.blackClr),
                  ),
                  onPressed: () {
                    bloc.saveAlarm(context);
                  },
                  // onPressed: () => _saveAlarm(context),
                  child: Text(
                    'SET',
                    style: Style.textStyleBtn(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDayName(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return '';
    }
  }
}
