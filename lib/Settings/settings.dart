import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Helpers/stream_signal.dart';
import '../Startup/home_page.dart';
import '../Startup/main.dart';
import '../Startup/themes.dart';


class Settings extends StatefulWidget {
  Settings({super.key});

  static String theme = localStorage.getItem('theme') ?? 'Lavender';
  static bool budgetText =
      bool.tryParse(localStorage.getItem('budgetText') ?? '') ?? true;
  static String savedInfo = localStorage.getItem('savedInfo') ?? 'Time';
  static List<String> savedInfoOptions = ['Time', 'Cost', 'Season'];
  static bool savedGrid =
      bool.tryParse(localStorage.getItem('savedGrid') ?? '') ?? true;
  static bool smoothCreate =
      bool.tryParse(localStorage.getItem('smoothCreate') ?? '') ?? false;
  static bool filterAge =
      bool.tryParse(localStorage.getItem('filterAge') ?? '') ?? true;
  static bool filterLocation =
      bool.tryParse(localStorage.getItem('filterLocation') ?? '') ?? true;
  static bool filterSeason =
      bool.tryParse(localStorage.getItem('filterSeason') ?? '') ?? true;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _buildSwitch(String text, bool value, void Function(bool value) onChange) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Switch(
            value: value,
            onChanged: (value) {
              setState(() {
                onChange(value);
              });
            }),
        Text("  $text",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface)),
      ],
    );
  }

  _buildDropDown(String text, bool title, String value, List<String> options,
      void Function(String? value) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("  $text",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: title ? 25 : 20,
                height: title ? 1 : 0.9,
                color: Theme.of(context).colorScheme.onSurface)),
        Row(
          children: [
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: value,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onSurface),
              elevation: 16,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onChanged: (String? newValue) {
                // This is called when the user selects an item.
                onChange(newValue);
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.shadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropDown('App Theme', true, Settings.theme,
                      Themes.themeData.keys.toList(), (value) {
                        setState(() {
                          localStorage.setItem('theme', value ?? 'Lavender');
                          Settings.theme = value ?? 'Lavender';
                          print(Settings.theme);
                          StreamSignal.updateStream(streamController: mainStream, newData: {"theme": Settings.theme});
                        });
                      })
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("  Information Display",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.onSurface)),
                  _buildSwitch('Display Cost as Text', Settings.budgetText,
                          (bool value) {
                        Settings.budgetText = value;
                        localStorage.setItem('budgetText', value.toString());
                      }),
                  const SizedBox(height: 10),
                  _buildDropDown('Saved Ideas Info', false, Settings.savedInfo,
                      Settings.savedInfoOptions, (value) {
                        setState(() {
                          localStorage.setItem('savedInfo', value ?? 'Time');
                          Settings.savedInfo = value ?? 'Time';
                        });
                      }),
                  _buildSwitch('Saved Page Gridview', Settings.savedGrid,
                          (bool value) {
                        Settings.savedGrid = value;
                        StreamSignal.updateStream(streamController: HomePage.homePageStream);
                        localStorage.setItem('savedGrid', value.toString());
                      }),
                  _buildSwitch('Progressive Idea Customization', Settings.smoothCreate,
                          (bool value) {
                        Settings.smoothCreate = value;
                        StreamSignal.updateStream(streamController: HomePage.homePageStream);
                        localStorage.setItem('smoothCreate', value.toString());
                      }),
                ],
              ),
            ),
          ],
        ));
  }
}
