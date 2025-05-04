import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_screen.dart';
import 'package:untitled/utils/utils.dart';
import 'package:untitled/widgets/round_button.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {



  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });

    }).onError((error, stackTree) {
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

        title: Text('Sign Up'),
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
              title: 'Sign Up',
              loading: loading,
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
                Text('Already have an account?'),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                    },


                    child: Text('Login')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
