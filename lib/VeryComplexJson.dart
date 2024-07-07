
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/VeryComplexModel.dart';

class VeryComplexJson extends StatefulWidget {
  const VeryComplexJson({super.key});

  @override
  State<VeryComplexJson> createState() => _VeryComplexJsonState();
}

class _VeryComplexJsonState extends State<VeryComplexJson> {

  Future<VeryComplexModel> getUSerApi() async {
    final response = await http.get(Uri.parse('https://webhook.site/49a2bfa3-1c8b-4361-b184-b0e34d3c79a3'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
        return VeryComplexModel.fromJson(data);
    }
    else{
        return VeryComplexModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Complex Json',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
              Expanded(child: FutureBuilder<VeryComplexModel>(
                future: getUSerApi(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context,position){
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height *.25,
                                          width: MediaQuery.of(context).size.width * .5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                                image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()))
                                          ),
                                        ),
                                      );
                                    }),),
                              Icon(snapshot.data!.data![index].inWishlist == true ? Icons.favorite : Icons.favorite_outline)                            ],
                          );
                        });
                  }
                  else{
                    return const Text('LOading');
                  }
                },
              ))
          ],
        ),
      ),
    );
  }
}
