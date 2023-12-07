import 'package:flutter/material.dart';
import 'package:front_sena/utils/responsive.dart';
import 'package:front_sena/MainScreens/Welcome/mobile_welcome_screen.dart';
import 'package:front_sena/MainScreens/Welcome/web_welcome_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
          body: Responsive(
            mobile: SingleChildScrollView(
              child: MobileWelcomeScreen(),
            ),
            desktop: WebWelcomeScreen(),
          ),
        );
  }
}
