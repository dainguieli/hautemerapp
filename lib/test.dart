import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserScreen extends StatefulWidget {
  final String token;

  UserScreen({required this.token});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic> userDetails = {};

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://hautemerapp.gloryimpactgroup.org/public/api/user'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userDetails = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: userDetails.isNotEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${userDetails['name']}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Email: ${userDetails['email']}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
