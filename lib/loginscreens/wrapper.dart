import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natureview2/loginscreens/signup_screen.dart';
import 'package:natureview2/screens/navbar.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:((context, snapshot){
          if(snapshot.hasData){
            return const CustomBottomNavigationBar();
          }
          else{
            return const SignupScreen();
          }
        }) 
        ),
    );
  }
}