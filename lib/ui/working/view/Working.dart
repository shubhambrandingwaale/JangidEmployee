import 'dart:io';

import 'package:attendance_employee/Components/Colors.dart';
import 'package:attendance_employee/Components/Image.dart';
import 'package:attendance_employee/Components/MainComponents.dart';
import 'package:attendance_employee/widgets/Button.dart';
import 'package:attendance_employee/widgets/CustomTextFeilds.dart';
import 'package:path_provider/path_provider.dart';
import 'package:attendance_employee/ui/working/controller/WorkingRepository.dart';
import 'package:attendance_employee/ui/working/model/AttendanceModel.dart';
import 'package:attendance_employee/utility/Colors.dart';
import 'package:attendance_employee/utility/CustomFont.dart';
import 'package:attendance_employee/utility/CustomFunctions.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:attendance_employee/widgets/MyClick.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:attendance_employee/widgets/Regular.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class WorkingController extends StatelessWidget {
  const WorkingController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WorkingRepository(),
      child: Consumer(
        builder: (context, WorkingRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Working();
            case Status.Unauthenticated:
              return Working();
            case Status.Authenticating:
              return Working();
            case Status.Authenticated:
              return Working();
            case Status.error:
              return Working();
          }
        },
      ),
    );
  }
}

class Working extends StatefulWidget {
  Working({super.key});

  @override
  State<Working> createState() => _WorkingState();
}

class _WorkingState extends State<Working> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<dynamic> dta = [];
  TextEditingController _searchController = TextEditingController();

  Future<void> refresh() async {
    final auth = context.read<WorkingRepository>();
    print(await auth.getAttendanceById(context));
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<WorkingRepository>();
      print(await auth.getAttendanceById(context));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<WorkingRepository>();
    List<AllAttendanceWorker> filteredList = auth.attendanceList
        .where((entry) => entry.siteName
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: light_black,
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Appcolor.blue,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              MainComponents().Images(logo, 200.0),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Regular(
                      text: 'Attendance',
                      size: 15,
                      color: Appcolor.black,
                      fontWeight: CustomFontWeight.medium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextFeild(
                          HintText: 'Search by Site Name',
                          Radius: 10,
                          width: 220,
                          TextInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          height: 45,
                          controller: _searchController,
                          onchangeFuntion: (value) {
                            setState(() {});
                          },
                          isOutlineInputBorder: true),
                      Mybutton(
                          lable: 'Export',
                          height: 45,
                          width: 100,
                          bgcolor: Appcolor.blue,
                          color: Appcolor.White,
                          size: 15,
                          onPressed: () {
                            createExcelFile(filteredList);
                          })
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(children: [
                  PaginatedDataTable(
                    columnSpacing: 38.0,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    rowsPerPage: 10, // Set the number of rows per page
                    columns: [
                      DataColumn(
                        label: const Text('Sr.no'),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            _sortColumnIndex = columnIndex;
                            _sortAscending = ascending;
                            auth.attendanceList.sort((a, b) {
                              if (ascending) {
                                return a.createdAt.compareTo(b.createdAt);
                              } else {
                                return b.createdAt.compareTo(a.createdAt);
                              }
                            });
                          });
                        },
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text('Date'),
                            SizedBox(width: 5),
                            Icon(
                              _sortColumnIndex == 1
                                  ? _sortAscending
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward
                                  : null,
                            ),
                          ],
                        ),
                        numeric: false,
                        tooltip: 'Sort by Date',
                      ),
                      DataColumn(label: Text('Hours')),
                      DataColumn(label: Text('Check-in')),
                      DataColumn(label: Text('Checkout')),
                      DataColumn(label: Text('Site name')),
                    ],
                    source: _MyDataTableSource(filteredList),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<AllAttendanceWorker> _data;

  _MyDataTableSource(this._data);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }
    final record = _data[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(record.createdAt))),
      DataCell(Text(record.timeDiff)),
      DataCell(Text(Util.formatTime(record.checkIn))),
      DataCell(Text(Util.formatTime(record.checkOut))),
      DataCell(Text(record.siteName)),
    ]);
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

Future<void> createExcelFile(List<AllAttendanceWorker> data) async {
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('HH-mm-ss').format(DateTime.now());
  String fileName = 'AttendanceSheet-$currentDate-$currentTime.xlsx';

  sheet.appendRow(
      ['S.No.', 'Date', 'Hours', 'Check-in', 'Check-out', 'Site Name']);
  // Populate Excel sheet with data
  for (int row = 0; row < data.length; row++) {
    sheet.appendRow([
      '${row + 1}',
      DateFormat('dd/MM/yyyy').format(data[row].createdAt),
      data[row].timeDiff,
      Util.formatTime(data[row].checkIn),
      Util.formatTime(data[row].checkOut),
      data[row].siteName
    ]);
  }

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '/storage/emulated/0/Download/$fileName';
  Customlog(' file path is :$filePath');
  final excelBytes = await excel.encode();
  try {
    File(filePath).writeAsBytesSync(excelBytes!);
  } catch (e) {
    print('Error: $e');
  }
  openFile(filePath);
  // showNotification(filePath);
}

Future<void> showNotification(String filePath) async {
  bool areNotificationsAllowed =
      await AwesomeNotifications().isNotificationAllowed();

  if (!areNotificationsAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 0,
      channelKey: 'basic_channel',
      title: 'Excel File Downloaded',
      body: 'File is downloaded and ready to open.',
      // payload: {'filePath': filePath},
    ),
  );
  // openFile(filePath);

  // AwesomeNotifications().actionStream.listen((receivedNotification) {
  //   if (receivedNotification.payload != null &&
  //       receivedNotification.payload!['filePath'] != null) {
  //     openFile(receivedNotification.payload!['filePath']);
  //   }
  // });
}

void openFile(String filePath) {
  OpenFile.open(filePath);
}
