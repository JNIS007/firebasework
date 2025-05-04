import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/verify_code.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widgets/round_button.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {


  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          children: [
            SizedBox(height: 80,),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+977 9800000000'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Login',loading: loading, onTap: (){
              setState(() {
                loading = true;
              });
              
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });

                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false;
                    });
                  Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> VerifyCodeScreen(verificationId: verificationId,)
                  )
                  );
                  setState(() {
                    loading = false;
                  });},

                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
              );


            })

          ],
        ),
      ),
    );
  }
}
