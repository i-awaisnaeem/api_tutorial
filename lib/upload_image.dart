
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

 File? image;
 final  _picker =  ImagePicker();
 bool showSpinner = false;

 Future getImage() async{
   final pickedfile =  await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
   if (pickedfile != null ){
      image = File(pickedfile.path);
      setState(() {

      });
   }
   else{
    print('No Image Selected');
   }
 }

 Future<void> UploadImage() async {
   setState(() {
     showSpinner= true;
   });

   var stream = new http.ByteStream(image!.openRead());
   stream.cast();
   var length = await image!.length();
   var uri = Uri.parse('https://fakestoreapi.com/products');

   var request = new http.MultipartRequest('POST', uri);
   request.fields['title'];
   var multiport = new http.MultipartFile('image', stream, length);

   request.files.add(multiport);

   var response = await request.send();
   if (response == 200){
    setState(() {
      showSpinner = false;
    });
    print('image uploades');
   }
   else {
     setState(() {
       showSpinner = false;
     });
     print('failed');
   }
 }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null ? Center(child: Text('Pick Image'))
              : Container(
                    child: Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ) ,))
              ),
            ),
            SizedBox(height: 150),
            GestureDetector(
              onTap: (){
                UploadImage();
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
