// flutter libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_health_tracker/Helpers/database.dart';

// in project pages
import 'package:student_health_tracker/Startup/home_page.dart';
import 'package:student_health_tracker/startup/custom_themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Helpers/stream_signal.dart';

/*
Dart entrypoint for app.
Initializes app, and selects page to run.
In addition, initializes supabase instance for the whole application.
 */



// Main Stream Controller
final StreamController<StreamSignal> mainStream = StreamController<StreamSignal>();

Future<void> main() async {

  // set orientation to up
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // wait for local storage
  await initLocalStorage();

  if(!mainStream.hasListener){
    runApp(const MyApp());
  }
}


// Get a reference your Supabase client
final supabase = Supabase.instance.client;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mainStream.stream,
        initialData: StreamSignal(streamController: mainStream, newData: {
        'theme': CustomThemes.themeData['Lavender'],
        }),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Student Health Tracker',
            theme:
              CustomThemes.themeData['Lavender'],
            home: FutureBuilder(
                future: DataBase.init(),
                builder: (context, snapshot){
                  return const HomePage();})
          );
        });
  }
}