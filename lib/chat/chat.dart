
/*

Page to chat with ai about symptoms, general state of health in the area.

https://www.figma.com/design/ioLyqSZNwFykLdaX0yUMjp/Untitled?node-id=16-35&p=f&t=fxAz7LiXb64LFvmt-0

 */
import 'package:flutter/material.dart';


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
  final List<Map<String, String>> messages = [
    {
      'role': 'user',
      'text': 'I have symptoms like a headache and nausea. What potential sickness could I have?'
    },
    {
      'role': 'bot',
      'text': 'Potential Sicknesses:\n1. xyz\n2. xyz\n3. xyz\n4. xyz\n5. xyz'
    },
  ];

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
                        color: msg['role'] == 'user'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextField(
              controller: _controller,
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
        ],
      ),
    );
  }
}
