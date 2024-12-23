import 'package:flutter/material.dart';
import 'package:lets_meet/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blueAccent,
              Colors.lightBlue,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Start Your Meetings Now",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                    ),
                    Center(child: Image.asset('assets/images/login_icon.png')),
                    SizedBox(
                      height: 35,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                bool result = await _authMethods
                                    .signInWithGoogle(context);
                                if (result) {
                                  Navigator.pushNamed(context, '/home');
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: Text("LOGIN / SIGN UP",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 22, 108, 255)),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
