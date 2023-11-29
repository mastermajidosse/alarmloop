class AlrmState {
  final DateTime? alarmTime;
  final List<int>? alarmDays;
  final bool? isEnabled;

  const AlrmState({
    this.alarmTime,
    this.alarmDays,
    this.isEnabled = false,
  });
}
