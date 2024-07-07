
import 'dart:convert';

import 'Models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PluginModelScreen extends StatefulWidget {
  const PluginModelScreen({super.key});

  @override
  State<PluginModelScreen> createState() => _PluginModelScreenState();
}

class _PluginModelScreenState extends State<PluginModelScreen> {

  List<PostModel> postlist = []; // Because we have array in json without name

  Future<List<PostModel>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      postlist.clear();
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    }
    else{
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Model with plugins'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Text('Loading');
              }
              else{
                return ListView.builder(
                    itemCount: postlist.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Titile' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                          Text(postlist[index].title.toString()),
                        SizedBox(height: 5,),
                        Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                            SizedBox(height: 5,),
                        Text(postlist[index].body.toString())
                          ],
                        ),),
                      );
                    });
              }
            },
          ))

        ],
      ),
    );
  }
}
