import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_with_phone_number.dart';
import 'package:untitled/ui/auth/signup_screen.dart';
import 'package:untitled/ui/posts/post_screen.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widgets/round_button.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
          setState(() {
            loading = false;
          });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
        centerTitle: true
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',

                          prefixIcon: Icon(Icons.email_outlined)
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Password',

                          prefixIcon: Icon(Icons.lock_outline_rounded)
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Password';
                        }
                        else {
                          return null;
                        }
                      },
                    ),

                  ],
                )
            ),
            SizedBox(height: 50,),

            RoundButton(
              loading: loading,
              title: 'Login',
            onTap: (){

              if(_formKey.currentState!.validate()){
                login();

              }
            },
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())
                    );

                  },


                    child: Text('Sign Up')
                )
              ],
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginWithPhoneNumber()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black)
                ),
                child:
                Center(
                  child: Text('Login with phone number'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
