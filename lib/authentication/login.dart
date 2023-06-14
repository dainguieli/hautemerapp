import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hautemerapp/Service/auth_services.dart';
import 'package:hautemerapp/Service/globals.dart';
import 'package:hautemerapp/home_screen.dart';
import 'package:http/http.dart' as http;
import '../widget/customTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailControllerController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  /* String email = '';
  String password = '';
  */

  loginPressed() async {
    if (emailControllerController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      http.Response response = await AuthServices.login(
        emailControllerController.text,
        passwordController.text,
      );

      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),

          ),

        );
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, "Entre le mot de passe ou l'email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "images/login.png",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  isObsecre: false,
                  data: Icons.email,
                  controller: emailControllerController,
                  hinText: "Email",
                ),
                CustomTextField(
                  isObsecre: true,
                  data: Icons.lock,
                  controller: passwordController,
                  hinText: "Mot de passe",
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: loginPressed,
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),

          ),
        ],
      ),

    );
  }
}
