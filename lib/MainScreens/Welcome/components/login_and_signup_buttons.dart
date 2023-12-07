import 'package:flutter/material.dart';
import 'package:front_sena/MainScreens/Login/login_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: FilledButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen())),
          },
            child: Text("LOGIN"),
          ),
        ),
        Container(
          width: size.width * 0.8,
          child: OutlinedButton(
            onPressed: () {},
            child: Text("SING UP"),
          ),
        ),
      ],
    );
  }
}
