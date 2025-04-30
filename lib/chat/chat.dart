/*

Page to chat with AI about symptoms, general state of health in the area.

https://www.figma.com/design/ioLyqSZNwFykLdaX0yUMjp/Untitled?node-id=16-35&p=f&t=fxAz7LiXb64LFvmt-0

 */
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase package
import 'dart:convert';

class StudentHealthChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    // Initial message from the bot
    messages.add({
      'role': 'bot',
      'text':
          'Welcome to the Student Health Tracker Chat! How can I assist you today?'
    });
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      messages.add({'role': 'user', 'text': text});
    });

    // Call the GPT diagnose function using Supabase
    final response = await Supabase.instance.client.functions.invoke(
      'gpt-diagnose',
      body: json.encode({
        'symptoms': text,
        // Add other parameters if needed
      }),
    );

    if (response != null) {
      final data = response.data;
      final diagnosis =
          data['diagnosis'] ?? 'Sorry, I could not find a diagnosis.';
      setState(() {
        messages.add({'role': 'bot', 'text': diagnosis});
      });
    } else {
      setState(() {
        messages.add({
          'role': 'bot',
          'text': 'Error: Unable to get a response from the AI.'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 12),
            color: Color(0xFF5A55EA),
            child: Center(
              child: Text(
                'Student Health Tracker Chat',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            color: Color(0xFFE9F0FF),
            child: Center(
              child: Text(
                'Read Terms and Conditions',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextField(
              controller: _controller,
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  _sendMessage(text);
                  _controller.clear();
                }
              },
              decoration: InputDecoration(
                hintText: "Input your symptoms here",
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _sendMessage(_controller.text);
                _controller.clear();
              }
            },
            child: Text("Send"),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: messages.map((msg) {
                return Align(
                  alignment: msg['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: msg['role'] == 'user'
                          ? Color(0xFF8C85F4)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(
                        color:
                            msg['role'] == 'user' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
