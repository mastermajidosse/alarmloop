/*
 ** This File contains Fake Data for Testing Purposes
 ** 
 ** Use this data during development and testing to simulate alarms.
*/



import '../model/alarm_model.dart';
import '../model/sound_model.dart';

List<AlarmModel> fakeAlarms = [
     
      AlarmModel(
        id: 1,
        title: "Fake Alarm 1",
        isEnabled: false,
        sound:sounds[0], // replace with your sound model
        ringTime: "09:30 AM",
      ),
      AlarmModel(
        id: 2,
        title: "Fake Alarm 2",
        isEnabled: false,
        sound:sounds[1], // replace with your sound model
        ringTime: "10:30 AM",
      ),
      AlarmModel(
        id: 3,
        title: "Fake Alarm 3",
        isEnabled: false,
        sound:sounds[2], // replace with your sound model
        ringTime: "11:30 AM",
      ),
      AlarmModel(
        id: 4,
        title: "Fake Alarm 4",
        isEnabled: false,
        sound:sounds[3], // replace with your sound model
        ringTime: "12:30 AM",
      ),
      AlarmModel(
        id: 5,
        title: "Fake Alarm 3",
        isEnabled: false,
        sound:sounds[2], // replace with your sound model
        ringTime: "11:30 AM",
      ),
      AlarmModel(
        id: 6,
        title: "Fake Alarm 4",
        isEnabled: false,
        sound:sounds[3], // replace with your sound model
        ringTime: "12:30 AM",
      ),
      // Add more fake alarms as needed
    ];