import 'package:alarmloop/model/alarm_model.dart';
import 'package:alarmloop/ui/choose_alarm/choose_alarm_screen.dart';
import 'package:alarmloop/widgets/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/alarm_cubit.dart';
import '../../widgets/button/icon_button.dart';
import '../../widgets/button/my_chip.dart';

class EditScreen extends StatelessWidget {
  static String routeName = "/edit";
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    AlarmModel alarm = bloc.state.alarms[bloc.state.indexSelectedAlarm];
    // Initial Selected Value
    String dropdownvalue = 'min';

    // List of items in our dropdown menu
    var items = [
      'min',
      'h',
    ];

    TextEditingController loopIntervalController = TextEditingController();
    // TextEditingController alarmController = TextEditingController();

    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
      child: WillPopScope(
        onWillPop: () {
          bloc.cancelEditAlarm(context);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            title: const Text('Edit'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                bloc.cancelEditAlarm(context);
              },
              color: Colors.red,
              icon: const Icon(
                Icons.close,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // bloc.saveAlarm(context);
                  bloc.saveAlarmLabel(alarm.title);
                },
                color: Colors.red,
                icon: const Icon(Icons.check),
              ),
            ],
            elevation: 1,
          ),
          body: SafeArea(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: BlocBuilder<AlarmCubit, AlarmState>(
                          builder: (context, state) {
                        return Image.asset(
                          'assets/images/${alarm.sound.image}',
                          width: 150.w,
                          height: 150.h,
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ChooseAlarmScreen.routeName);
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
                          Icons.alarm,
                          color: Colors.red,
                        ),
                        GestureDetector(
                          onTap: () {
                            bloc.selectAlarmTime(context);
                          },
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
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ],
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
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Wrap(
                                children: [
                                  ...List.generate(
                                    loopIntervals.length,
                                    (int index) {
                                      bool isSelected = alarm.loopInterval ==
                                          loopIntervals[index];
                                      return MyChip(
                                        text: loopIntervals[index],
                                        backgroundColor: isSelected
                                            ? Colors.blue
                                            : Colors.grey.shade200,
                                        textColor: isSelected
                                            ? Colors.white
                                            : Colors.black,
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
                                            title:
                                                const Text('Add loop interval'),
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
                                                    controller:
                                                        loopIntervalController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    autofocus: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                            ),
                                                            hintText: 'Value'),
                                                  ),
                                                ),
                                                SizedBox(width: 20.w),
                                                StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return DropdownButton(
                                                    value: dropdownvalue,
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    items: items
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(items),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
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
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: const Divider(),
                    ),
                    // BlocBuilder<DaySelectionCubit, DaySelectionState>(
                    //   builder: (context, state) {
                    //     return Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: List.generate(
                    //         7,
                    //         (index) => DayCard(index),
                    //       ),
                    //     );
                    //   },
                    // ),
                    CustomTextField(
                      label: 'Alarm name',
                      icon: Icons.label,
                      initialAlarm: alarm.title,
                      onChanged: (value) {
                        // Handle the changed value
                        alarm.title = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<AlarmCubit, AlarmState>(
                          builder: (context, state) {
                            alarm.isEnabled = bloc.isTimerOn();
                            return MyIconButton(
                              text: bloc.isTimerOn() ? 'Turn Off' : 'Turn On',
                              iconData: bloc.isTimerOn()
                                  ? Icons.notifications_off
                                  : Icons.notifications,
                              onPressed: () {
                                bloc.isTimerOn()
                                    ? bloc.turnOffTimer(alarm.id)
                                    : bloc.turnOnTimer(
                                        alarm.id, alarm.sound.sound);
                              },
                            );
                          },
                        ),
                        MyIconButton(
                          text: 'Delete',
                          iconData: Icons.delete,
                          onPressed: () {
                            bloc.deleteAlarm(context, alarm.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getDayName(int index) {
    // Adjust the index to start from Monday
    final dayIndex = (index + 1) % 7;
    switch (dayIndex) {
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
