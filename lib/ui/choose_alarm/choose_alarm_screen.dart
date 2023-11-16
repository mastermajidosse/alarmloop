import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/alarm_cubit.dart';
import '../../model/sound_model.dart';

class ChooseAlarmScreen extends StatelessWidget {
  static String routeName = "/choose_alarm";
  const ChooseAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    // bloc.getSoundsList();
    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          title: const Text('Select Sound'),
          centerTitle: true,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.red,
              icon: const Icon(
                CupertinoIcons.music_note,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<AlarmCubit, AlarmState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text("Editor's Choice"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      itemCount: sounds.length,
                      itemBuilder: (BuildContext context, int index) {
                        SoundModel sound = sounds[index];

                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            bloc.setAlarmSound(context, index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey),
                              ),
                            ),
                            height: 60.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Row(
                              children: [
                                // play/pause button
                                GestureDetector(
                                  onTap: () {
                                    bloc.playPauseAudio(index, sound.sound);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2.w,
                                        color: Colors.red,
                                      ),
                                    ),
                                    child: Icon(
                                      state.indexPlayingSound == index
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),

                                // alarm icon
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: Image.asset(
                                    'assets/images/${sound.image}',
                                    width: 50.w,
                                    height: 50.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // sound details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sound.name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    const Text(
                                      'universal',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
