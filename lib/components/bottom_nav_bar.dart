import 'package:book_tracker_app/view/home.dart';
import 'package:flutter/material.dart';

import '../view/history.dart';
import '../view/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

List<IconData> navIcon = [Icons.history, Icons.home, Icons.person];

List<String> navTitle = ["History", "Home", "Profile"];

List<Widget> navPage = [History(), HomePage(), Profile()];

int selectedIndex = 1;

class _NavBarState extends State<NavBar> {
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navPage[selectedIndex],
      bottomNavigationBar: Container(
        height: 65,
        margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
        decoration: BoxDecoration(
            color: const Color(0xFF8F3985),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: navIcon.map((icon) {
            int index = navIcon.indexOf(icon);
            bool isSelected = selectedIndex == index;
            return Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  onTabTapped(index);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 0, left: 35, right: 35),
                        child: Icon(icon,
                            color: isSelected
                                ? const Color(0xFF07BEB8)
                                : Colors.white),
                      ),
                      Text(
                        navTitle[index],
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF07BEB8)
                              : Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
