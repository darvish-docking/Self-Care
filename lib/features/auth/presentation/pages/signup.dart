import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('signup page')
            ],
          ),
        ),
      ),
    );
  }
}