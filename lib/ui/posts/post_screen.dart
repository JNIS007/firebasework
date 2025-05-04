import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_screen.dart';
import 'package:untitled/ui/posts/add_post.dart';
import 'package:untitled/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilterController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
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

          StreamBuilder(
            stream: FirebaseDatabase.instance.ref("your/path").onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return Center(child: Text("No data available"));
              }

              final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              final list = data.values.toList();

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return ListTile(
                    title: Text(item['title'] ?? 'No Title'),
                    subtitle: Text(item['id']?.toString() ?? 'No ID'),
                  );
                },
              );
            },
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilterController,
              decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          SizedBox(height: 10,),


          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder:  (context,snapshot,animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if(searchFilterController.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );

                  }else if (title.toLowerCase().contains(searchFilterController.text.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  }else{
                    return Container();
                  }
                }
                ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostScreen()));

          },
          child: Icon(Icons.add, color: Colors.white,),
          ),
    );
  }
}
