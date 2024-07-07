import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModel extends StatefulWidget {
  const WithoutModel({super.key});

  @override
  State<WithoutModel> createState() => _WithoutModelState();
}

class _WithoutModelState extends State<WithoutModel> {

  var data;
 Future<void> getUserApi () async {
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   if (response.statusCode == 200){
     data = jsonDecode(response.body.toString());
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Without Model'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Text('Loading');
              }
              else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index){
              return Card(child: Column(
                children: [
                  ReuseableRow(name: 'Name', value: data[index]['name'].toString()),
                  ReuseableRow(name: 'Email', value: data[index]['email'].toString()),
                  ReuseableRow(name: 'Geo', value: data[index]['address']['geo']['lat'].toString()),
                ],
              ),);
              });}
            },
          ))
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String name ,value;
  ReuseableRow({super.key, required this.name,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name ,style: const TextStyle(fontWeight: FontWeight.bold),),
        Text(value)
      ],
    );
  }
}