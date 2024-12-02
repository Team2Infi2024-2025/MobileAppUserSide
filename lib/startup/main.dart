// flutter libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_health_tracker/Helpers/database.dart';

// in project pages
import 'package:student_health_tracker/Startup/home_page.dart';
import 'package:student_health_tracker/Startup/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Helpers/stream_signal.dart';

/*
Dart entrypoint for app.

Initializes app, and selects page to run.

In addition, initializes supabase instance
 */

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // on init, run the app
  await initLocalStorage();
  if(!mainStream.hasListener){
    runApp(const MyApp());
  }
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

// Main Stream Controller
final StreamController<StreamSignal> mainStream = StreamController<StreamSignal>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mainStream.stream,
        initialData: StreamSignal(streamController: mainStream, newData: {
        'theme': localStorage.getItem('theme') ?? 'Lavender',
        }),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Student Health Tracker',
            theme:
              Themes.themeData[snapshot.data?.data['theme']] ?? Themes.themeData['Lavender'],
            home: FutureBuilder(
                future: DataBase.init(),
                builder: (context, snapshot){
                  return const HomePage();})
          );
        });
  }
}