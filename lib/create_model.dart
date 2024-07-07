import 'dart:convert';
import 'package:api_tutorial/Models/Photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateModelScreen extends StatefulWidget {
  const CreateModelScreen({super.key});

  @override
  State<CreateModelScreen> createState() => _CreateModelScreenState();
}

class _CreateModelScreenState extends State<CreateModelScreen> {

  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data =jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    }
    else {
      return photosList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create own models'),backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos() ,
                builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text(snapshot.data![index].title.toString()),
                      );
                    });
                }),
          )
        ],
      ),
    );
  }
}


