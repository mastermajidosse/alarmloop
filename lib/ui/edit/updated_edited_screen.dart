import 'package:alarmloop/model/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../core/core.dart';
import '../../cubit/alarm_cubit.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import '../../cubit/set_alarm_time_cubit.dart';
import '../../cubit/set_alarm_time_state.dart';
import '../../utils/style.dart';
import '../../widgets/button/my_chip.dart';
import '../choose_alarm/choose_alarm_screen.dart';
import 'package:timezone/timezone.dart' as tz;

// ignore: must_be_immutable
class UpdatedEditAlarmForm extends StatefulWidget {
  final int alarmIndex;
  static String routeName = "/update-edited-screen";
  UpdatedEditAlarmForm({this.alarmIndex = 0});

  @override
  State<UpdatedEditAlarmForm> createState() => _UpdatedEditAlarmFormState();
}

class _UpdatedEditAlarmFormState extends State<UpdatedEditAlarmForm> {
  @override
  Widget build(BuildContext context) {
    final notificationCubit = BlocProvider.of<NotificationCubit>(context);
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    int selectedAlarmIndex = bloc.state.indexSelectedAlarm ?? 0;

    AlarmModel alarm = bloc.state.alarms[selectedAlarmIndex];
    // AlarmModel alarm = bloc.state.alarms[bloc.state.indexSelectedAlarm];

    // Initial Selected Value
    String dropdownvalue = 'min';

    // List of items in our dropdown menu
    var items = [
      'min',
      'h',
    ];
    TextEditingController loopIntervalController = TextEditingController();
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
                // !alarm.isAm
                //     ? Transform(
                //         alignment: Alignment.center,
                //         transform: Matrix4.rotationY(3.14),
                //         child: Icon(
                //           Icons.dark_mode_outlined,
                //           size: 30.0,
                //           color: Colors.grey,
                //         ),
                //       )
                //     : Transform(
                //         alignment: Alignment.center,
                //         transform: Matrix4.rotationY(3.14),
                //         child: Icon(
                //           Icons.wb_sunny,
                //           size: 30.0,
                //           color: Colors.orange,
                //         ),
                //       ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () => bloc.selectAlarmTime(context),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           GestureDetector(
                //             onTap: () {},
                //             child: BlocBuilder<AlarmCubit, AlarmState>(
                //               builder: (context, state) {
                //                 return Text(
                //                   alarm.ringTime,
                //                   style: TextStyle(
                //                     fontSize: 30.sp,
                //                     fontWeight: FontWeight.w500,
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //           SizedBox(width: 10),
                //           Text(
                //             bloc.setIsAm() ? 'AM' : 'PM',
                //             style: Style.textStyleBtn(),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Icon(
                //       Icons.arrow_forward_ios_rounded,
                //       color: Colors.white,
                //     ),
                //   ],
                // ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.loop_rounded,
                      color: Colors.red,
                    ),
                    BlocBuilder<AlarmCubit, AlarmState>(
                        builder: (context, state) {
                      bloc.getLoopIntervals();
                      List<String> loopIntervals = state.loopIntervals;

                      return Wrap(
                        children: [
                          ...List.generate(
                            loopIntervals.length,
                            (int index) {
                              bool isSelected =
                                  alarm.loopInterval == loopIntervals[index];

                              return MyChip(
                                text: loopIntervals[index],
                                backgroundColor: isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade200,
                                textColor:
                                    isSelected ? Colors.white : Colors.black,
                                onTap: () {
                                  bloc.setselectedLoopInterval(
                                      loopIntervals[index]);
                                },
                              );
                            },
                            growable: true,
                          ),
                          MyChip(
                            text: '+',
                            backgroundColor: Colors.grey.shade200,
                            textColor: Colors.black,
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierLabel: 'Add loop interval',
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Add loop interval'),
                                    actions: [
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Add"),
                                        onPressed: () {
                                          bloc.addLoopInterval(
                                            context,
                                            "${loopIntervalController.text} $dropdownvalue",
                                            alarm.id.toString(),
                                          );
                                        },
                                      ),
                                    ],
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: TextField(
                                            controller: loopIntervalController,
                                            keyboardType: TextInputType.number,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                hintText: 'Value'),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        StatefulBuilder(
                                            builder: (context, setState) {
                                          return DropdownButton(
                                            value: dropdownvalue,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              dropdownvalue = newValue!;
                                              setState(() {});
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }),
                  ],
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
                          onChanged: (value) async {
                            if (value == true) {
                              bloc.turnOnCheckBox(alarm.id);
                            } else {
                              bloc.turnOffCheckBox(alarm.id, context);
                              // BlocProvider.of<NotificationCubit>(context)
                              //     .cancelN(alarm.id);
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
                // TextButton(
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Style.whiteClr),
                //     textStyle: MaterialStateProperty.all(
                //       TextStyle(color: Style.blackClr),
                //     ),
                //     foregroundColor: MaterialStateProperty.all(Style.blackClr),
                //   ),
                //   onPressed: () async {
                //     DateTime ringTime = DateFormat.Hm().parse(alarm.ringTime);
                //     int hours = ringTime.hour;
                //     int minutes = ringTime.minute;

                //     final moroccoTimeZone = tz.getLocation('Africa/Casablanca');
                //     final now = tz.TZDateTime.now(moroccoTimeZone);
                //     final alarmTime = tz.TZDateTime(moroccoTimeZone, now.year,
                //         now.month, now.day, hours, minutes);
                //     print("Local Time: ${alarmTime.toLocal()}");
                //     print("Local Time: $alarmTime");

                //     bloc.saveAlarm(context);
                //     if (alarm.isEnabled) {
                //       await _scheduleAlarm(alarmTime);
                //     }
                //   },
                //   // onPressed: () => _saveAlarm(context),
                //   child: Text(
                //     'SET',
                //     style: Style.textStyleBtn(),
                //   ),
                // ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Style.whiteClr),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Style.blackClr),
                    ),
                    foregroundColor: MaterialStateProperty.all(Style.blackClr),
                  ),
                  onPressed: () async {
                    final moroccoTimeZone = tz.getLocation('Africa/Casablanca');
                    final now = tz.TZDateTime.now(moroccoTimeZone);
                    int hours = now.hour;
                    int minutes = now.minute;
                    dynamic ringTime = '$hours:$minutes';
                    alarm.ringTime = ringTime;
                    print("Local Time: ${tz.TZDateTime.now(moroccoTimeZone)}");
                    bloc.saveAlarm(context);
                    await notificationCubit.scheduleAlarm(
                      tz.TZDateTime.now(moroccoTimeZone),
                      alarm.sound.sound.split('.')[0],
                      alarm.id,
                      alarm.loopInterval,
                    );
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
}
