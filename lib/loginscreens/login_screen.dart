import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:natureview2/button.dart';
import 'package:natureview2/loginscreens/signup_screen.dart';
import 'package:natureview2/screens/navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _value = false;
  bool obscureText = true;
  bool loginButtonClicked = false;
  TextStyle checkboxTextStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextStyle emailHintStyle = const TextStyle(color: Colors.grey);

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
              'assets/signuplot.json',
              height: screenSize.height * .40,
            ),
            Text(
              'Login',
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
                      top: screenSize.height * 0.03),
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
                  top: screenSize.height * 0.050),
              child: Row(
                children: [
                  Text(
                    'New to NatureVew2?',
                    style: TextStyle(
                        fontSize: screenSize.height * 0.017,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    )),
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                          fontSize: screenSize.height * 0.017,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3396B4)),
                    ),
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              text: 'Login',
              onPressed: () async {
                setState(() {
                  loginButtonClicked = true;
                });

                // If email field is empty-----------------------------
                if (emailController.text.isEmpty) {
                  setState(() {
                    emailHintStyle = const TextStyle(color: Colors.red);
                  });
                  return;
                }

                // Checking whether the checkbox is ticked and email is not empty--------------------------
                if (!_value) {
                  // If the checkbox is not ticked-----------------------------
                  setState(() {
                    checkboxTextStyle = const TextStyle(color: Colors.red);
                  });
                  return;
                }
                try {
                  UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  // Authentication failed, show an error dialog-------------------------------
                  String errorMessage = "An error occurred. Please try again.";

                  if (e.code == 'user-not-found' ||
                      e.code == 'wrong-password') {
                    errorMessage = 'Incorrect email or password.';
                  }

                  _showErrorDialog(errorMessage);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
