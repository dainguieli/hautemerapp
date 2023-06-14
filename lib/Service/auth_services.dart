import 'dart:convert';

import 'package:hautemerapp/Service/globals.dart';
import 'package:hautemerapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse("${baseURL}auth/register");
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse("${baseURL}auth/login");
    http.Response response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: body,
    );

    print(response.body);
    return response;
  }



  // get token
  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('token'));

    return pref.getString('token') ?? '';
  }

// get user id
  static Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

// logout
  static Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }
}





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