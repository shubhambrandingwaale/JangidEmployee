import 'package:attendance_employee/Components/Colors.dart';
import 'package:attendance_employee/Components/Image.dart';
import 'package:attendance_employee/Components/MainComponents.dart';
import 'package:attendance_employee/ui/working/view/Working.dart';
import 'package:attendance_employee/ui/home/controller/HomeRepository.dart';
import 'package:attendance_employee/utility/Colors.dart';
import 'package:attendance_employee/utility/CustomFont.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:attendance_employee/widgets/AnimatedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeRepository(),
      child: Consumer(
        builder: (context, HomeRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Home();
            case Status.Unauthenticated:
              return Home();
            case Status.Authenticating:
              return Home();
            case Status.Authenticated:
              return Home();
            case Status.error:
              return Home();
          }
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isGPSEnabled = true;
  void next() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkingController()));
  }

  Future<void> refresh() async {
    final auth = context.read<HomeRepository>();
    print(await auth.checkGPSStatus());
    if (!auth.isGPSEnabled) {
      setState(() {
        _isGPSEnabled = auth.isGPSEnabled;
      });
    }
    print(await auth.getCurrentLocation(context));
    auth.getHomeData(context);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<HomeRepository>();
      print(await auth.checkGPSStatus());
      if (!auth.isGPSEnabled) {
        setState(() {
          _isGPSEnabled = auth.isGPSEnabled;
        });
      }
      print(await auth.getCurrentLocation(context));
      auth.getHomeData(context);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<HomeRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: auth.status == Status.Authenticating
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: SafeArea(
                child: auth.homeData != null
                    ? Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius:
                                              0.5, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MainComponents().txtview14('Dashboard'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Util.logoutalertnew(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius:
                                                0.5, // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MainComponents().txtview14('Logout'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          MainComponents().Images(logout, 30.0)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MainComponents().Images(logo, 200.0),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(10),
                                child: auth.homeData != null
                                    ? MainComponents().txtview15(
                                        "Hello, ${auth.homeData!.workerName ?? ""}")
                                    : Container()),
                            auth.homeData != null
                                ? MainComponents().homeCards(
                                    context,
                                    time_to_pay,
                                    request_money,
                                    "Daily Wage",
                                    "Total payout this month",
                                    "₹ ${auth.homeData!.dailyWage ?? ""}",
                                    "₹ ${auth.homeData!.totalPayoutThisMonth}",
                                    "",
                                    "")
                                : Container(),
                            auth.homeData != null
                                ? MainComponents().homeCards(
                                    context,
                                    money_bag,
                                    time,
                                    "Paid this month",
                                    "Pending Payout",
                                    "₹ ${auth.homeData!.paidThisMonth}",
                                    "₹ ${auth.homeData!.pendingPayout}",
                                    "",
                                    "")
                                : Container(),
                            const SizedBox(
                              height: 50,
                            ),
                            MyAnimatedbutton(
                                lable: auth.buttonName(
                                    context, auth.homeData!.isPresent),
                                height: 60,
                                width: size.width * 0.80,
                                bgcolor: Appcolor.blue,
                                color: Appcolor.White,
                                fontweigth: CustomFontWeight.semibold,
                                size: 15,
                                onPressed: () async {
                                  print(await auth.checkGPSStatus());
                                  if (auth.isGPSEnabled) {
                                    if (auth.btnText == 'Punch-In') {
                                      auth.PunchIn(context);
                                    } else {
                                      auth.PunchOut(context);
                                    }
                                  } else {
                                    Util.showmessagebar(
                                        context, 'Please Enable Your Location');
                                  }
                                })
                            // MainComponents().Button("Logout", () => next(), red)
                          ],
                        ),
                      )
                    : Container(),
              ),
            ),
    );
  }
}
