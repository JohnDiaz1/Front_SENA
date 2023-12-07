import 'package:flutter/material.dart';
import 'package:front_sena/MainScreens/Welcome/welcome_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:front_sena/MainScreens/Home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              TextField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: FilledButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                  },
                  child: Text("LOGIN"),
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black
                  ),
                  children: [
                    TextSpan(
                        text: "Sing Up",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen())),
                    ),
                  ]
                ),
              ),
            ],
          ),
        );
  }
}
