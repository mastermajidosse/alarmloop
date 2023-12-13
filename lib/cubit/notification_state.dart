import 'package:flutter/material.dart';

class NotificationState {
  final List<Notification>? notificationsScheduled;
  final String? error;

  NotificationState({
    this.notificationsScheduled,
    this.error,
  });

  NotificationState copyWith({
    List<Notification>? notificationsScheduled,
    String? error,
  }) {
    return NotificationState(
      notificationsScheduled: notificationsScheduled ?? this.notificationsScheduled,
      error: error ?? this.error,
    );
  }
}
