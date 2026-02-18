import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/core/theme/app_text_styles.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/start_2.dart';


class StartPage1 extends StatefulWidget{
  const StartPage1({super.key, required String title});

@override
State<StartPage1> createState() => _StartPage1State();
}



class _StartPage1State extends State<StartPage1> {
  
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future <void> _initializeApp() async{
    // Simulate API call / app initialization
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StartPage2(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
          
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(), // Spacer() takes all remaining free space inside a Column or Row.
                
                    // 🔹 Heading
                    Text(
                      "Self Care",
                      style: AppTextStyles.heading,
                      textAlign: TextAlign.center,
                    ),
              
                    const SizedBox(height: 32),
              
                    // 🔹 Logo
                    Image.asset(
                      'assets/images/logo medicine 1 4 3.png',
                      height: 120,
                    ),
                
                    // const SizedBox(height: 40),
                    const Spacer(),
              
                    
                  ],
                ),
              ),
          
              // 🔹 Subheading
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Loading...",
                    style: AppTextStyles.subHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
            
            ],
          ),
        ),
      ),
    );
  }
}

