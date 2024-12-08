import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Helpers/stream_signal.dart';
import '../Startup/main.dart';
import '../helpers/global_methods.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                color: Colors.black)),
        Row(
          children: [
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
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
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const SizedBox(height: 10),
            // Feedback Section
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("  Feedback",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.black)),
                  TextButton(
                      onPressed: () {
                        Alert(
                            context: context,
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Have Feedback for our App?\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                                const Text('Email us at ______@vt.edu or',
                                    style: TextStyle(fontSize: 20)),
                                TextButton(
                                    onPressed: () {
                                      GlobalMethods.launchURL(
                                          'https://forms.office.com/pages/responsepage.aspx?id=4vjWLNg-okKNt2o-XhA8E3sdf-IDjQtMpHPPhgI3s11UQzFSNFBTNzhVNVZFSkZOR0U1V0YwWFUyVC4u&origin=lprLink');
                                    },
                                    child: const Text(
                                        'Fill out our feedback form!',
                                        style: TextStyle(fontSize: 20)))
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                  color: Colors.grey,
                                  child: const Text("Got it!",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ]).show();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        height: 35,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.feedback, color: Colors.white),
                            Text(
                              ' Give Us Some Feedback! ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(height: 10)
                ],
              ),
            )
          ],
        ));
  }
}
