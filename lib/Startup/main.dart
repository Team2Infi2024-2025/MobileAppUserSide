// flutter libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';

// in project pages
import 'package:student_health_tracker/Startup/home_page.dart';
import 'package:student_health_tracker/Startup/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Helpers/stream_signal.dart';


/*
Dart entrypoint for app.

inits app and home page.
 */

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://cwuqeskcuzbzxxdkkgno.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3dXFlc2tjdXpienh4ZGtrZ25vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA3NjAyNjEsImV4cCI6MjA0NjMzNjI2MX0.ll5U0251lxqwQU8691ZHXPFnBO8otEQljVYtjvhGCFs',
  );
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Health Tracker',
        theme: Themes.themeData['Lavender'],
        builder: (context, snapshot) {
          return HomePage();
        }
    );
  }
}