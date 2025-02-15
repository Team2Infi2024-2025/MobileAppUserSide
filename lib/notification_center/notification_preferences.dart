import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
Initially select notification preferences before going to notification center.
Allows users to customize which types of notifications they want to receive.
*/

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({Key? key}) : super(key: key);

  @override
  _NotificationPreferencesState createState() => _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  bool generalNotifications = true;
  bool healthUpdates = true;
  bool locationAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notification Center'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Information regarding common and\ncurrent health information.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Text(
                    'Location: ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Blacksburg, VA',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'General Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: const Text('General Notifications'),
              value: generalNotifications,
              onChanged: (bool value) {
                setState(() {
                  generalNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Health Updates'),
              value: healthUpdates,
              onChanged: (bool value) {
                setState(() {
                  healthUpdates = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Location Alerts'),
              value: locationAlerts,
              onChanged: (bool value) {
                setState(() {
                  locationAlerts = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}