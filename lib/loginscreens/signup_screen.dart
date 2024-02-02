// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:natureview2/button.dart';
import 'package:natureview2/loginscreens/login_screen.dart';
import 'package:natureview2/screens/navbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _value = false;
  bool obscureText = true;
  bool signupButtonClicked = false;
  TextStyle checkboxTextStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextStyle emailHintStyle = const TextStyle(color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
              'assets/loginlot.json',
              height: screenSize.height * .40,
            ),
            Text(
              'Sign up',
              style: TextStyle(
                  fontSize: screenSize.height * 0.04,
                  fontWeight: FontWeight.w700),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.height * 0.02,
                      top: screenSize.height * 0.025),
                  child: Text(
                    'Email:',
                    style: TextStyle(
                        fontSize: screenSize.height * 0.02,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.height * 0.02,
                      right: screenSize.height * 0.02,
                      top: screenSize.height * 0.01),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: const Color(0xFF3396B4),
                        hintText: 'example@gmail.com',
                        hintStyle: emailHintStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.height * 0.02,
                      top: screenSize.height * 0.01),
                  child: Text(
                    'Password:',
                    style: TextStyle(
                        fontSize: screenSize.height * 0.02,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.height * 0.02,
                    right: screenSize.height * 0.02,
                    top: screenSize.height * 0.01,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordController,
                      obscureText:
                          obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_outlined),
                        prefixIconColor: const Color(0xFF3396B4),
                        hintText: 'password',
                        hintStyle: emailHintStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF3396B4),
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                    shape: const CircleBorder(),
                    value: _value,
                    onChanged: (bool? value) {
                      setState(() {
                        _value = value!;
                      });
                    }),
                Text(
                  'By clicking you are agreeing the Terms And Conditions',
                  style: checkboxTextStyle,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenSize.height * 0.05,
                top: screenSize.height * 0.055,
              ),
              child: Row(
                children: [
                  Text(
                    'Already a user in NatureVew2?',
                    style: TextStyle(
                        fontSize: screenSize.height * 0.017,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    )),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenSize.height * 0.017,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3396B4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              text: 'Sign up',
              onPressed: () async {
                setState(() {
                  signupButtonClicked = true;
                });

                // If email field is empty-------------------
                if (emailController.text.isEmpty) {
                  setState(() {
                    emailHintStyle = const TextStyle(color: Colors.red);
                  });
                  return;
                }

                // Checking whether the checkbox is ticked and email is not empty------------------
                if (!_value) {
                  // If the checkbox is not ticked----------------------
                  setState(() {
                    checkboxTextStyle = const TextStyle(color: Colors.red);
                  });
                  return;
                }

                // Perform Firebase authentication----------------------------------
                try {
                  UserCredential userCredential =
                      await _auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  // Authentication failed, print the error--------------------
                  print("Firebase Authentication Error: ${e.message}");

                  // Show an error dialog-------------------------------------
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Authentication Error"),
                        content: Text("The emial entered is invalid or already exists please try again"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
