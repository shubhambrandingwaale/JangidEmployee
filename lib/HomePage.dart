import 'package:attendance_employee/Components/Colors.dart';
import 'package:attendance_employee/ui/home/view/Home.dart';
import 'package:attendance_employee/ui/payout/view/Payout.dart';
import 'package:attendance_employee/ui/working/view/Working.dart';
import 'package:attendance_employee/widgets/ToastBar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pagecontroller = PageController();
  final List<Widget> pages = [
    HomeController(),
    WorkingController(),
    PayoutController()
  ];

  int current_index = 0;

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toastbar.showToast(msg: "double tap to exit !!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: light_black,
          body: Container(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pagecontroller,
              // onPageChanged: (index){
              //   current_index = index;
              // },
              children: pages,
            ),
          ),
          bottomNavigationBar: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                color: Colors.black,
                activeColor: Colors.black,
                tabBackgroundColor: bottom_navi,
                gap: 8,
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                    onPressed: () {
                      setState(() {
                        pagecontroller.jumpToPage(0);
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.work_history_outlined,
                    text: 'Working',
                    onPressed: () {
                      setState(() {
                        pagecontroller.jumpToPage(1);
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.payment_outlined,
                    text: 'Payout',
                    onPressed: () {
                      setState(() {
                        pagecontroller.jumpToPage(2);
                      });
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  pageview() {
    if (current_index == 0) {
      pagecontroller.jumpToPage(0);
    }
    if (current_index == 1) {
      pagecontroller.jumpToPage(1);
    }
    if (current_index == 2) {
      pagecontroller.jumpToPage(2);
    }
  }
}
