import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;

  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef =  FirebaseDatabase.instance.ref('Post');


  Future getGalleryImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);

      }else {
        print('no image picked');
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getGalleryImage();

                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child:_image != null ? Image.file(_image!.absolute):Center(
                    child: Icon
                      (Icons.image),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Upload', loading: loading, onTap: ()async{
              setState(() {
                loading = true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/img/' + DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

               Future.value(uploadTask).then((value)async{
                var newUrl =  await ref.getDownloadURL();

                databaseRef.child('1').set({
                  'id' : '1234',
                  'title' : newUrl.toString()
                }).then((value){
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Uploaded');

                }).onError((error, stackTrace){
                  setState(() {
                    loading = false;
                  });
                });

              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });




            })
          ],
        ),
      ),
    );
  }
}
