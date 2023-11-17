// Cubit
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState(false));

  void initializeApp() {
    Timer(Duration(seconds: 2), () {
      emit(SplashState(true));
    });
  }
}