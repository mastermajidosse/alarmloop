import 'package:alarmloop/ui/home/updated_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../splash_cubit/splash_cubit.dart';
import '../../splash_cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash-screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initializeApp(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isInitialized) {
            // Navigate to the main screen or any other screen after initialization
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => UpdatedHomeScreen()),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_icon.gif',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
