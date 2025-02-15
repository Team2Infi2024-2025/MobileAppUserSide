import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*

Notification center.

Display any notifications sent out of the application.

Essentially need to locally store a list of all notifs sent out (can back up to supabase), and then display.
 */

class NotificationCenter extends StatefulWidget {
	@override
	_NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
	List<Map<String, dynamic>> notifications = [];

	@override
	void initState() {
		super.initState();
		//fetchNotifications();
	}

/*
	Future<void> fetchNotifications() async {
		final response = await supabase.from('notifications').select().execute();
		if (response.error == null) {
			setState(() {
				notifications = List<Map<String, dynamic>>.from(response.data);
			});
		} else {
			// Handle error
			print('Error fetching notifications: ${response.error!.message}');
		}
	}

*/
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Notification Center'),
				backgroundColor: Colors.blue,
			),
			body: notifications.isEmpty
					? Center(child: CircularProgressIndicator())
					: ListView.builder(
							itemCount: notifications.length,
							itemBuilder: (context, index) {
								final notification = notifications[index];
								return Card(
									margin: const EdgeInsets.all(8.0),
									child: Padding(
										padding: const EdgeInsets.all(16.0),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													notification['title'] ?? 'No Title',
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontSize: 16,
													),
												),
												SizedBox(height: 8),
												Text(
													notification['message'] ?? 'No Message',
													style: TextStyle(fontSize: 14),
												),
												SizedBox(height: 8),
												Text(
													notification['date'] != null
															? notification['date'].toString()
															: 'No Date',
													style: TextStyle(fontSize: 12, color: Colors.grey),
												),
											],
										),
									),
								);
							},
						),
		);
	}
}