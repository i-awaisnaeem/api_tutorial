import 'package:api_tutorial/VeryComplexJson.dart';
import 'package:api_tutorial/WithoutModel.dart';
import 'package:api_tutorial/complex_model.dart';
import 'package:api_tutorial/create_model.dart';
import 'package:api_tutorial/dropdown_api.dart';
import 'package:api_tutorial/login.dart';
import 'package:api_tutorial/plugin_model.dart';
import 'package:api_tutorial/signup.dart';
import 'package:api_tutorial/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Api Demo',
     // home: PluginModelScreen(), // When model is made by plugin
     // home: CreateModelScreen(), // When you have to create your on model
    // home: ComplexModelScreen(), // Complex model with plugin
    //  home: WithoutModel(),
   // home: VeryComplexJson(), // When Json start with object

    // to view json structure  // https://jsonviewer.stack.hu/
      // for fake apis // https://webhook.site/

   // home: Signup(), //https://reqres.in/
    //  home : Login()

  //    home: UploadImage(),
      home: DropdownApi(),
    );
  }
}
