import 'package:flutter/material.dart';
import 'package:front_sena/utils/assets_images.dart';
import 'package:front_sena/MainScreens/Welcome/components/login_and_signup_buttons.dart';

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to the App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: size.height * 0.03,),
          AssetsImages.ImageWelcome(),
          SizedBox(height: size.height * 0.05,),
          LoginAndSignupBtn(),
        ],
      ),
    );
  }
}
