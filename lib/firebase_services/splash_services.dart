


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_screen.dart';
import 'package:untitled/ui/firestore/firestore_list_screen.dart';
import 'package:untitled/ui/posts/post_screen.dart';
import 'package:untitled/ui/upload_image.dart';

class  SplashServices{


  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3) , () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()
          )
          )
      );
    }else{
      Timer(Duration(seconds: 3) , () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
          )
          )
      );
    }


  }


}