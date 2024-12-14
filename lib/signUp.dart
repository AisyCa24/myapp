import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() {
  runApp(SignUps());
}

class SignUps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class SignUp extends StatelessWidget {
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
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 230,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  _buildLabeledTextField(
                      label: "Full Name",
                      hintText: 'Enter Your Name',
                      isPassword: false),
                  SizedBox(height: 20),
                  _buildLabeledTextField(
                      label: "Email Address",
                      hintText: 'example@gmail.com',
                      isPassword: false),
                  SizedBox(height: 20),
                  _buildLabeledTextField(
                    label: "Password",
                    hintText: '*****',
                    isPassword: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homescreene(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFD8150),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        child: Text(
                          "Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/images/socialmedia/google.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/socialmedia/apple.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/socialmedia/facebook.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFFFD8150),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget _buildLabeledTextField({
  required String label,
  required String hintText,
  required bool isPassword,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 8),
      TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}
