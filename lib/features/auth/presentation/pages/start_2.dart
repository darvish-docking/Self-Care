import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/core/theme/app_text_styles.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/start_3.dart';

class StartPage2 extends StatelessWidget{
  const StartPage2({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [

          /// 🔹 Top Image Section (3/4 height)
          SizedBox(
            height: height * 0.75,
            width: width,
            child: Stack(
              fit: StackFit.expand,
              children: [
            
                // Background Image
                Image.asset(
                  'assets/images/image.png',
                  fit: BoxFit.cover,
                ),
            
                // Logo Overlay
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset(
                      'assets/images/Logo.png',
                      height: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Bottom Content Section (1/4 height)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  // Heading
                  Text(
                    "Manage your health and happy future",
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // Image Button
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 200,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage3()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,     // Button color
                        foregroundColor: AppColors.surface,     // Text color
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Get started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
