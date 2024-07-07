import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email': email,
            'password': password
          }
      );
      if (response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print (data);
        print('Login successfully');
      }
      else{
        print('failed');
      }
    }
    catch(e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Api'),
        backgroundColor: Colors.teal ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Email'
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'Password'
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal
                ),
                child: const Center(
                  child: Text('Login'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}