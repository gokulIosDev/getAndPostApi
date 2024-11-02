import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app/Models/singnUpModel.dart';
import 'package:news_app/Screens/widgets/uiHelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp "),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Enter Email"),
          UiHelper.CustomTextField(passwordController, "Enter Password"),
          UiHelper.CustomTextField(userNameController, "Enter UserName"),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signUp(emailController.text.toString(), passwordController.text.toString(), userNameController.text.toString());
              },
              child: const Text("SignUp"))
        ],
      ),
    );
  }

  Future<void> signUp(String email, String password, String userName) async {
    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      log("Enter Required Field");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("https://news-app-eosin-beta.vercel.app/newsapp/signup"),
        body: jsonEncode({"email": email, "username": userName, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        SignUpModel signUpModel = SignUpModel.fromJson(responseData);
        String message = responseData["message"];
        print(responseData);
        log(message);
      } else {
        log("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
  }
}
