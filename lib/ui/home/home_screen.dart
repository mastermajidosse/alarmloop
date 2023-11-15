import 'package:alarmloop/model/sound_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/alarm_cubit.dart';
import '../../model/alarm_model.dart';
import '../../utils/demo_data.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    bloc.getAlarmsList();
    

    // Replace this line with bloc.getAlarmsList() when fetching real alarms
    /// The line `bloc.setAlarmsList(fakeAlarms);` is setting the list of alarms in the `AlarmCubit` to
    /// a list of fake alarms (`fakeAlarms`). This is likely used for testing or demonstration purposes,
    /// where the `fakeAlarms` list is predefined and used as a placeholder until the real alarms are
    /// fetched or provided.
    bloc.setAlarmsList(fakeAlarms);
     
    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(246, 246, 246, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.red,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title: const Text('Alarm Loop'),
          centerTitle: true,
          elevation: 1,
          foregroundColor: Colors.red,
          actions: [
            IconButton(
              onPressed: () {
                bloc.addNewAlarm(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            child: BlocBuilder<AlarmCubit, AlarmState>(
              builder: (context, state) {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.w,
                    childAspectRatio: 0.56.h,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 14.w,
                  ),
                  // itemCount: state.alarms.length,
                  itemCount: fakeAlarms.length,
                  itemBuilder: (context, index) {

                    /// The line `AlarmModel alarm = fakeAlarms[index];` is assigning the `AlarmModel`
                    /// object at the specified `index` in the `fakeAlarms` list to the `alarm`
                    /// variable.
                    AlarmModel alarm = fakeAlarms[index];

                    // AlarmModel alarm = state.alarms[index];

                    return GestureDetector(
                        onTap: () {
                          bloc.editAlarm(context, index);
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(alarm.title), 
                              Container(
                                decoration: BoxDecoration(
                                  color: alarm.isEnabled
                                      ? Colors.white
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                      width: 1.w, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset(
                                  'assets/images/${alarm.sound.image}',
                                  width: 100.w,
                                  height: 100.h,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                alarm.ringTime,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
