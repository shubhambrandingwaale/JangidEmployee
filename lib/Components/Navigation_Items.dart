import 'package:attendance_employee/Components/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navigation_bar_items {
  Widget Navigations(int _index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: bottom_navi,
          gap: 8,
          onTabChange: (index) {
            _index = index;
            print(index);
          },
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.work_history_outlined,
              text: 'Working',
            ),
            GButton(
              icon: Icons.payment_outlined,
              text: 'Payout',
            ),
          ]),
    );
  }
}
