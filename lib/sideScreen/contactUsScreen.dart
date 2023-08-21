import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class contactUsScreen extends StatefulWidget {
  const contactUsScreen({super.key});

  @override
  State<contactUsScreen> createState() => _contactUsScreenState();
}

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();
Future sendEmail() async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_rm9j7ec";
  const templateId = "template_62t10xg";
  const userId = "kq3H19bEAR1e_4hy3";
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text,
        }
      }));
  return response.statusCode;
}

class _contactUsScreenState extends State<contactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.white])),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Contact",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " Us",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])),
                  // Text(
                  //   "Contact Us",
                  //   style: TextStyle(
                  //     fontSize: 35,
                  //     color: Colors.orange,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * .75,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image/contactUs.jpg"),
                            fit: BoxFit.cover,
                            opacity: .4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 9,
                              offset: Offset(2, 7),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(200),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 30),
                        child: Container(
                          margin: EdgeInsets.only(right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "+91 XXXX XXXXXX",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                  "Jeet.040316@gmail.com",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Row(
                                      //   children: [
                                      //     Icon(
                                      //       Icons.location_on,
                                      //       color: Colors.orange,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 20,
                                      //     ),
                                      //     Expanded(
                                      //       child: SingleChildScrollView(
                                      //         scrollDirection: Axis.horizontal,
                                      //         child: Text(
                                      //             "A G C R Pin Code is 110002.\nA G C R is located in\nA CENTRAL DELHI,DELHI, India.",
                                      //             style: TextStyle(
                                      //                 color: Colors.white)),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                    child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fillColor:
                                              Colors.white.withOpacity(.6),
                                          filled: true,
                                          hintText: 'Name',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.black38),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fillColor:
                                              Colors.white.withOpacity(.6),
                                          filled: true,
                                          hintText: 'Email',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.black38),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: TextFormField(
                                        controller: subjectController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fillColor:
                                              Colors.white.withOpacity(.6),
                                          filled: true,
                                          hintText: 'Subject',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.black38),
                                          prefixIcon: Icon(
                                            Icons.subject,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fillColor:
                                              Colors.white.withOpacity(.6),
                                          filled: true,
                                          hintText: 'Message',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.black38),
                                          prefixIcon: Icon(
                                            Icons.message,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.orange)),
                                        onPressed: () {
                                          sendEmail();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Send",
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: FloatingActionButton(
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
