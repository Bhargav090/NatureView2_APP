import 'package:flutter/material.dart';
import 'package:natureview2/home_page.dart';
import 'package:natureview2/screens/premium.dart';
import 'package:natureview2/screens/profile.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _items = [
   HomeScreen(),
    PremiumScreen(),
    ProfileScreen(),
  ];

  int cIndex = 0;

  final _iconLinearGradient = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _items[cIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3396B4).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: SweetNavBar(
          currentIndex: cIndex,
          items: [
            SweetNavBarItem(
              sweetActive: const Icon(Icons.home),
              sweetIcon: const Icon(Icons.home_outlined),
              sweetLabel: 'Home',
              iconColors: _iconLinearGradient,
            ),
            SweetNavBarItem(
              sweetActive: const Icon(Icons.workspace_premium_sharp),
              sweetIcon: const Icon(Icons.workspace_premium_outlined),
              sweetLabel: 'Premium',
              iconColors: _iconLinearGradient,
            ),
            SweetNavBarItem(
              sweetActive: const Icon(Icons.person_remove_rounded),
              sweetIcon: const Icon(Icons.perm_identity_rounded),
              sweetLabel: 'Profile',
              iconColors: _iconLinearGradient,
            ),
          ],
         onTap: (index) {
          setState(() {
            cIndex = index;
          });}
        ),
      ),
    );
  }
}
