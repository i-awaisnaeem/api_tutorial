import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_tutorial/Models/ComplexModel.dart';

class ComplexModelScreen extends StatefulWidget {
  const ComplexModelScreen({super.key});

  @override
  State<ComplexModelScreen> createState() => _ComplexModelScreenState();
}

class _ComplexModelScreenState extends State<ComplexModelScreen> {

  List<ComplexModel> complexList = [];

  Future<List<ComplexModel>> getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for(Map i in data){
        complexList.add(ComplexModel.fromJson(i));
      }
      return complexList;
    }
    else {
      return complexList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Model'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<ComplexModel>> snapshot){

              if (!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              else{
              return ListView.builder(
                  itemCount: complexList.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReuseableRow(
                                name: 'Name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReuseableRow(
                                name: 'Username',
                                value: snapshot.data![index].username.toString(),
                              ),
                              ReuseableRow(
                                name: 'Email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReuseableRow(
                                name: 'Address',
                                value: snapshot.data![index].address!.city.toString(),

                              )
                            ],
                          ),
                        ),
                      ),
                    );
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
