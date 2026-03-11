import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/register_user_usercases.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/signin.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/otp_provider.dart';




class OtpEnterPage extends StatefulWidget{
  const OtpEnterPage({super.key});

  @override
  State<OtpEnterPage> createState() => OtpEnterPageState();
}

class OtpEnterPageState extends State<OtpEnterPage>{


  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // final role =
    // context.read<SignupFormProvider>().selectedUserRole;

    // final gender =
    //     context.read<SignupFormProvider>().selectedGender;
    // final dob =
    //     context.read<SignupFormProvider>().selectedDob;
    // final location = context.read<SignupFormProvider>().selectedCountry;

    // final fullName = context.read<SignupFormProvider>().fullName;
    // final email = context.read<SignupFormProvider>().email;
    // final password = context.read<SignupFormProvider>().password;

// final registration = RegistrationEntity(
//   role: role,
//   gender: gender!,
//   dob: dob!,
//   location: location!,
//   name: fullName,
//   email: email,
//   password: password,
// );

    
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => OtpProvider()..startTimer(),
          child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: screenHeight * 0.05),

                      /// LOGO
                      Image.asset(
                        'assets/images/logo medicine 1 4 5.png',
                        height: screenHeight * 0.12,
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      /// HEADING
                      const Text(
                        "Your Code",
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: screenHeight * 0.015),

                      /// SUBHEADING
                      const Text(
                        "Code send to your Email",
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      /// OTP FIELDS
                      Consumer<OtpProvider>(
                        builder: (context, provider, _) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(4, (index) {
                                
                                      return OtpInputField(
                                        onChanged: (value) {
                                          provider.setDigit(index, value);
                                      
                                          if (value.isNotEmpty) {
                                            if (index < 3) {
                                              FocusScope.of(context)
                                                  .requestFocus(_focusNodes[index + 1]);
                                            } else {
                                              _focusNodes[index].unfocus();
                                            }
                                          } else {
                                            if (index > 0) {
                                              FocusScope.of(context)
                                                  .requestFocus(_focusNodes[index - 1]);
                                            }
                                          }
                                        }, 
                                        focusNode: _focusNodes[index], 
                                        controller: _controllers[index],
                                      );
                                    
                                    }
                                ),
                              ),
                           
                          
                          if (provider.showError) ...[
                             SizedBox(height: screenHeight * 0.01),
                             Text(
                              provider.errorMessage!,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 14,
                              ),
                            ),
                          ],
                            ],
                          );
                        }
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      
                      /// COUNTDOWN + RESEND
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Consumer<OtpProvider>(
                            builder: (context, provider, _) {
                              return RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                              
                                    /// Seconds Remaining
                                    TextSpan(
                                      text: provider.canResend
                                          ? "   (00:00)    "
                                          : "   (00:${(provider.secondsRemaining)})    ",
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                              
                                    /// Resend Code (Grey)
                                    const TextSpan(
                                      text: "Resend Code? ",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                              
                                    /// Click Here (Green + Clickable)
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: provider.canResend
                                            ? provider.resendCode
                                            : null,
                                        child: Text(
                                          "Click here",
                                          style: TextStyle(
                                            color: provider.canResend
                                                ? AppColors.primary
                                                : AppColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            decoration: TextDecoration.underline,
                                            decorationColor: provider.canResend
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                      
                      SizedBox(height: screenHeight * 0.08),

                      Consumer<OtpProvider>(
                        builder: (context, provider, _) {
                          return SizedBox(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.07,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (provider.isVerifying) return;

                                final success = await provider.verifyOtp();

                                if (success && context.mounted) {

                                  // to call function in domain/usecases/register_user_usercases.dart
                              
                                  // final registerUserUseCase =
                                  //   context.read<RegisterUserUseCase>();
                                  // await registerUserUseCase(registration);

        
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SignInPage(),
                                    ),
                                  );
                                }
                                
                              },
                          
                              child: provider.isVerifying
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text("Verify", style: TextStyle(fontSize: 16),),
                            ),
                          );
                        }
                      ),

                      ],
                  )
                  ),
                )
              
          )
        )
      );
  
    }

  }





class OtpInputField extends StatelessWidget {

  final Function(String) onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;

  const OtpInputField({
    super.key,
    required this.onChanged,
    required this.focusNode,
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // final bool hasError =  false;

    return SizedBox(
      width: width * 0.16,
      child: TextField(
        maxLength: 1,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        decoration:  InputDecoration(
          filled: true,
          fillColor: AppColors.cardBackground,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: 
                // hasError ? AppColors.error : 
                AppColors.cardBackground,
                width: 2,
              ),
            ),
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
