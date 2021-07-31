import 'package:flash_chat/components/navigation_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_indicators/progress_indicators.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool progressIndicator = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: progressIndicator
          ? Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 60.0,
                color: Colors.blueAccent,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
                      ),
                      onChanged: (value) {
                        email = value;
                      }),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Hero(
                    tag: 'register',
                    child: NavigationButton(
                      text: 'Register',
                      onPressed: () async {
                        setState(() {
                          progressIndicator = true;
                        });
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            progressIndicator = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      colour: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
