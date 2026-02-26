import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';

class ThankyouScreen extends StatelessWidget {
  

  const ThankyouScreen({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                /// Back Button
                      Row(
                        children: [
                          IconButton(
                            icon: SvgPicture.asset("assets/icons/left arrow.svg",
                            width: 15,
                            height: 15,),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            "Back",
                            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 20),

                // Success Icon
                Container(
                  width: 100,
                  child: Text('Successs'))])))));
                  }}