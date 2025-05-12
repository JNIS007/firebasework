import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widgets/round_button.dart';


class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {

  final postController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users');
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 5,
              decoration:  InputDecoration(
                  hintText: 'What do u want to post?',
                  border: OutlineInputBorder()
              ),


            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  firestore.doc(id).set({
                    'title' : postController.text.toString(),
                    'id' : id
                  }).then((value){
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });

                })
          ],
        ),
      ),

    );
  }






}
