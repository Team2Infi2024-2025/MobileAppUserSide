import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../Helpers/stream_signal.dart';
import '../Startup/main.dart';
import '../Startup/themes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static String theme = localStorage.getItem('theme') ?? 'Lavender';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget _buildDropDown(
      String text,
      bool title,
      String value,
      List<String> options,
      void Function(String? value) onChange
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "  $text",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: title ? 25 : 20,
              height: title ? 1 : 0.9,
              color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: value,
              icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onSurface
              ),
              elevation: 16,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20
              ),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChange(newValue);
                }
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        // If using Cupertino, this will ensure the back button is visible
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropDown(
                    'App Theme',
                    true,
                    Settings.theme,
                    Themes.themeData.keys.toList(), (value) {
                      setState(() {
                        localStorage.setItem('theme', value ?? 'Lavender');
                        Settings.theme = value ?? 'Lavender';
                        print(Settings.theme);
                        StreamSignal.updateStream(
                            streamController: mainStream,
                            newData: {"theme": Settings.theme}
                        );
                      });
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}