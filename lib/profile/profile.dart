import 'dart:convert';
import 'package:hautemerapp/Service/auth_services.dart';
import 'package:hautemerapp/Service/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hautemerapp/models/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
String name='';
String email='';
  Future<User> fetchUserData(String token) async {
    final response = await http.get(
      Uri.parse('${baseURL}/user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return User(
        name: responseData['name'],
        email: responseData['email'],
      );
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
  void getUser() async {
    final user = await fetchUserData(token.toString());
   name=user.name!;
    email=user.email!;

  }
  Future token = AuthServices.getToken();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
