import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: screenWidth * 0.005,
                      blurRadius: screenWidth * 0.02,
                      offset: Offset(0, screenHeight * 0.01),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  color: Color(0xFF3396B4),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      children: [
                        Icon(
                          Icons.perm_identity_rounded,
                          color: Colors.white,
                          size: screenWidth * 0.12,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? '',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GestureDetector(
              child: Container(
                height: screenHeight * 0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEC407A),
                      Color(0xFFAA00FF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      spreadRadius: screenWidth * 0.005,
                      blurRadius: screenWidth * 0.02,
                      offset: Offset(0, screenHeight * 0.01),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'Become a Pro',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 116, 208, 220).withOpacity(0.2),
                    spreadRadius: screenWidth * 0.005,
                    blurRadius: screenWidth * 0.02,
                    offset: Offset(0, screenHeight * 0.01),
                  ),
                ],
              ),
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                color: Color(0xFF3396B4),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Text(
                        'Feedback Section',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter your feedback here...',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 135, 203, 214).withOpacity(0.2),
                    spreadRadius: screenWidth * 0.005,
                    blurRadius: screenWidth * 0.02,
                    offset: Offset(0, screenHeight * 0.01),
                  ),
                ],
              ),
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                color: Color.fromARGB(255, 12, 12, 12),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By Bhargav Pathivada',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchEmail('bhargavpathivada.09@gmail.com');
                        },
                        child: Row(
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                // Sign out the current user
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/signup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3396B4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
              ),
              child: Container(
                height: screenHeight * 0.08,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(_emailLaunchUri.toString() as Uri)) {
      await launchUrl(_emailLaunchUri.toString() as Uri);
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }
}
