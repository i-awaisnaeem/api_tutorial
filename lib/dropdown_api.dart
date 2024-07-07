import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

import 'Models/DropdownModel.dart';

class DropdownApi extends StatefulWidget {
  const DropdownApi({super.key});

  @override
  State<DropdownApi> createState() => _DropdownApiState();
}

class _DropdownApiState extends State<DropdownApi> {

  //
  Future<List<DropdownModel>> getPost ()async{
    try{

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final body = json.decode(response.body) as List;

    if (response.statusCode == 200){
      return body.map((dynamic e){
        final map = e as Map<String , dynamic>;
        return DropdownModel(
         userId: map['userId'],
        id : map['id'],
          title: map['title'],
          body: map['body'],
        );
    }).toList();
    }
  } on SocketException{
      throw Exception('No Internet');
    }
    throw Exception('Error fetching data');
    }

    var selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            FutureBuilder(
                future: getPost(),
                builder: (context,snapshot){
                  if (snapshot.hasData){
                    return DropdownButton(
                      value: selectedValue,
                         isExpanded : true,
                        icon: const Icon(Icons.add_circle_outline),
                        hint: const Text('Select value'),
                        items: snapshot.data!.map((e){
                          return DropdownMenuItem(
                              value: e.title.toString(),
                              child: Text(e.title.toString())
                           ) ;
                        }).toList(),
                        onChanged: (value){
                        selectedValue = value;
                        setState(() {

                        });
                        });
                  }
                  else{
                    return const CircularProgressIndicator();
                  }
                })
        ],
      ),
      ),
    );
  }
}
