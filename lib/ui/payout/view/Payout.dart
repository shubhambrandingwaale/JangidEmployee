import 'package:attendance_employee/Components/Colors.dart';
import 'package:attendance_employee/Components/Image.dart';
import 'package:attendance_employee/Components/MainComponents.dart';
import 'package:attendance_employee/ui/cards/workerPayoutCard.dart';
import 'package:attendance_employee/ui/payout/controller/PayoutRepository.dart';
import 'package:attendance_employee/utility/Colors.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayoutController extends StatelessWidget {
  const PayoutController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PayoutRepository(),
      child: Consumer(
        builder: (context, PayoutRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Payout();
            case Status.Unauthenticated:
              return Payout();
            case Status.Authenticating:
              return Payout();
            case Status.Authenticated:
              return Payout();
            case Status.error:
              return Payout();
          }
        },
      ),
    );
  }
}

class Payout extends StatefulWidget {
  const Payout({super.key});

  @override
  State<Payout> createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  Future<void> refresh() async {
    final auth = context.read<PayoutRepository>();
    print(await auth.getWorkerPayout(context));
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<PayoutRepository>();
      print(await auth.getWorkerPayout(context));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<PayoutRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Appcolor.blue,
        child: SafeArea(
          child: Container(
              child: Column(
            children: [
              MainComponents().Images(logo, 200.0),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: MainComponents().txtview15("Payout - Salary")),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: auth.payoutListData.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return WorkerPayoutCard(
                          workerPayout: auth.payoutListData[index],
                        );
                      }),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
