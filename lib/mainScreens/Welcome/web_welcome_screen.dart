import 'package:flutter/material.dart';
import 'package:front_sena/MainScreens/Welcome/components/login_and_signup_buttons.dart';
import 'package:front_sena/utils/assets_images.dart';

class WebWelcomeScreen extends StatelessWidget {
  const WebWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AssetsImages.ImageWelcome(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 450,
                child: LoginAndSignupBtn(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
