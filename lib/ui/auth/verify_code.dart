import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/posts/post_screen.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';



class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {



  bool loading = false;
  final auth = FirebaseAuth.instance;
  final verificationCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          children: [
            SizedBox(height: 80,),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: verificationCodeController,
              decoration: InputDecoration(
                  hintText: '6-digit code'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify',loading: loading, onTap: ()async{
              setState(() {
                loading = true;
              });

              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString()
              );

              try{

                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen()));

              }catch(e){
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(e.toString());

              }



            })

          ],
        ),
      ),
    );
  }
}