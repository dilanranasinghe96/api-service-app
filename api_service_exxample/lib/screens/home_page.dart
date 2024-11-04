import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
        backgroundColor: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          onPressed: () {
            fetchUsers();
          }),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final fname = user['name']['first'];
          final lname = user['name']['last'];
          final email = user['email'];
          final thumbnail = user['picture']['thumbnail'];

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black,
              child: ListTile(
                tileColor: Colors.amber.shade300,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text(fname + ' ' + lname),
                subtitle: Text(email),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(thumbnail),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
  }
}
