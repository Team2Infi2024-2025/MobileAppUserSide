import 'package:flutter/material.dart';
import 'notification_preferences.dart';
import 'notification_center.dart';

class NotificationPageRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if preferences have been selected
    bool preferencesSelected = false; // Replace with actual logic to check preferences

    return preferencesSelected
        ? NotificationCenter() // Navigate to Notification Center if preferences are selected
        : NotificationPreferences(); // Navigate to Notification Preferences otherwise
  }
}