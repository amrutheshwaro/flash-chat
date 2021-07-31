import 'package:flash_chat/components/navigation_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset(
                        'images/logo.png',
                      ),
                      height: animation.value * 60,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: 'login',
              child: NavigationButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                colour: Colors.lightBlueAccent,
              ),
            ),
            Hero(
              tag: 'register',
              child: NavigationButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
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
