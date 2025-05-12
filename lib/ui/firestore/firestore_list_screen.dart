import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_screen.dart';
import 'package:untitled/ui/firestore/add_firestore_data.dart';
import 'package:untitled/ui/posts/add_post.dart';
import 'package:untitled/utils/utils.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });

          },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),

          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if(snapshot.hasError ) {
                return Text('Error');
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                  return ListTile(
                    onTap: (){
                      // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                      //   'title' : 'ging tutorials'
                      // }).then((value){
                      //   Utils().toastMessage('Updated');
                      // }).onError((error, stackTrace){
                      //   Utils().toastMessage(error.toString());
                      // });

                      ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();

                    },
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                    subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                  );
                }),
              );

            },
          ),
          SizedBox(height: 20,),
          
          SizedBox(height: 10,),



        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFirestoreDataScreen()));

        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }


  Future<void> showMyDialog(String title, String id) async{
    editController.text = title;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                  hintText: 'Edit'
              ),

            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                child: Text('Update')),

          ],
        );
      },
    );

  }
}