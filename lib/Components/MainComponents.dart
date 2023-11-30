import 'package:attendance_employee/Components/Colors.dart';
import 'package:attendance_employee/Components/MediaQuery.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Image.dart';

class MainComponents {
  Widget Button(txt, Function() func, Color btcolor) {
    return MaterialButton(
      onPressed: () => func(),
      color: btcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget Textfields(
      label, TextEditingController edit_controller, hint, IconData iconData,
      {Function? passwordToggle,
      bool isPasswordVisible = true,
      bool isPassword = false}) {
    return TextField(
      controller: edit_controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: light_black, style: BorderStyle.solid)),
          label: Text(label),
          hintText: hint,
          prefixIcon: Icon(iconData),
          suffixIcon: Visibility(
            visible: isPassword,
            child: InkWell(
                onTap: () {
                  if (passwordToggle != null) {
                    passwordToggle!();
                  }
                },
                child: isPasswordVisible
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off)),
          )),
      obscureText: !isPasswordVisible,
    );
  }

  Widget Cards(TextEditingController usercontroller,
      TextEditingController passwordcontrol, func, btcolor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              MainComponents().Textfields(
                  "username", usercontroller, "Enter Username", Icons.person),
              SizedBox(
                height: 10,
              ),
              MainComponents().Textfields(
                  "password", passwordcontrol, "Enter Password", Icons.lock),
              SizedBox(
                height: 10,
              ),
              MainComponents().Button("Login", func, btcolor)
            ],
          ),
        ),
      ),
    );
  }

  Widget txtview28(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
    );
  }

  Widget txtview14(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  Widget txtview13(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400),
    );
  }

  Widget txtview15(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
          fontSize: 19, fontWeight: FontWeight.w500, color: blue),
    );
  }

  Widget txtview11(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400),
    );
  }

  Widget txtview12(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  Widget txtview18(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: blue,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget txtview23(txt) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w600,
        color: blue,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget Images(location, img_width) {
    return Image.asset(
      location,
      width: img_width,
    );
  }

  Widget homeCards(BuildContext context, cardimg1, cardimg2, carduptxt1,
      carduptxt2, cardlowtxt1, cardlowtxt2, cardsublowtxt1, cardsublowtxt2) {
    return Container(
      width: media_query().mquery(context, 1),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Images(cardimg1, 35.0),
                    SizedBox(
                      width: 1,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            child: txtview11(carduptxt1),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MainComponents().txtview14(cardlowtxt1),
                                const SizedBox(
                                  width: 13,
                                ),
                                MainComponents().txtview12(cardsublowtxt1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Images(cardimg2, 35.0),
                    const SizedBox(
                      width: 1,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            child: txtview11(carduptxt2),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MainComponents().txtview14(cardlowtxt2),
                                const SizedBox(
                                  width: 13,
                                ),
                                MainComponents().txtview12(cardsublowtxt2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Deductions_list() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Images(working, 30.0),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  txtview18("Sanjeev Singh"),
                                  txtview13("sent 15:22, 17 Oct, 2023"),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
                            decoration: DottedDecoration(
                                shape: Shape.box,
                                dash: [4, 1],
                                borderRadius: BorderRadius.circular(20)),
                            child: txtview14("-1510"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Divider(
                        color: lowblack,
                        thickness: .1,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
