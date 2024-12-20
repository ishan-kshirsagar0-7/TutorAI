import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat_interface.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/login_bg2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            color: Color.fromRGBO(242, 237, 237, 0.839),
                          ),
                          width: 380,
                          height: 450,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width: 150,
                                    height: 150,
                                    child: Image(
                                      image: AssetImage(
                                        "assets/tutorailogo5.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 45,
                                      ),
                                      Text(
                                        "TutorAI",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            5,
                                            39,
                                            67,
                                          ),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 45,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Making education",
                                        style: TextStyle(
                                          fontSize: 19,
                                        ),
                                      ),
                                      Text(
                                        "accessible to all",
                                        style: TextStyle(
                                          fontSize: 19,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(19),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Builder(
                                          builder: (BuildContext context) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatInterface(),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.school_rounded,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Login as Student",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                      255,
                                                      2,
                                                      14,
                                                      24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(19),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Builder(
                                          builder: (BuildContext context) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatInterface(),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.cases_rounded,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Login as Teacher",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                      255,
                                                      2,
                                                      14,
                                                      24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "Sign up now",
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        color: const Color.fromARGB(
                                          255,
                                          64,
                                          106,
                                          139,
                                        ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
