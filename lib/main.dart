import 'package:flutter/material.dart';
import 'signUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFD8150),
                Color(0xE0FD9A73),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Enjoy Your Food!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Inter",
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFD8150),
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "NIKI NIKU",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFD8150),
                  Color(0xE0FD9A73),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Let’s get started!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Inter",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUps(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        child: Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )),
      ),
    );
  }
}
