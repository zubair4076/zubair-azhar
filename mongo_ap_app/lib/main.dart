import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _controller = TextEditingController();
  List users = [];

  void fetchUsers() async {
    var response = await http.get(Uri.parse('http://localhost:3000/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
    }
  }

  void addUser() async {
    await http.post(
      Uri.parse('http://localhost:3000/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': _controller.text}),
    );
    _controller.clear();
    fetchUsers();
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter MongoDB')),
      body: Column(
        children: [
          TextField(controller: _controller),
          ElevatedButton(onPressed: addUser, child: Text('Add User')),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) => ListTile(title: Text(users[i]['name'])),
            ),
          ),
        ],
      ),
    );
  }
}
