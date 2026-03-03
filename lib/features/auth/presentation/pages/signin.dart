import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/otp.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/signup.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/signin_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/pages/home.dart';
import 'package:selfcare_mobileapp/features/home/presentation/pages/main_screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600, // Tablet control
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Center(
                          child: Image.asset(
                            'assets/images/logo medicine 1 4 5.png',
                            height: 60,
                          ),
                        ),
                        SizedBox(height: 16),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary
                          ),
                        ),
                        SizedBox(height: 40),
                        _SignInForm(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




class _SignInForm extends StatelessWidget {
  const _SignInForm();

  @override
  Widget build(BuildContext context) {
  //   final hasError = context.select<SigninFormProvider, bool>(
  // (p) => p.showTermsError,
// );
    return LayoutBuilder(
      builder: (context, constraints) {
        final fieldWidth = constraints.maxWidth * 0.9;
        final buttonWidth = constraints.maxWidth * 0.5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            
            SizedBox(
              width: fieldWidth,
              child:  _InputField(
                label: "Email",
                errorText: context.select<SigninFormProvider, String?>(
                  (p) => p.emailError,
                ),
                onChanged:
                    context.read<SigninFormProvider>().updateEmail,
              ),
            ),

            

            SizedBox(
              width: fieldWidth,
              child:  _InputField(
                label: "Password",
                isPassword: true,
                errorText: context.select<SigninFormProvider, String?>(
                  (p) => p.passwordError,
                ),
                onChanged:
                    context.read<SigninFormProvider>().updatePassword,
              ),
            ),

            const SizedBox(height: 16),

            // Forgot password (LEFT ALIGNED)
            SizedBox(
              width: fieldWidth,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const [
                      
                      TextSpan(
                        text: "Forgot your password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decorationColor: AppColors.primary,
                          color: AppColors.primary
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 200),

            // SIGN in BUTTON (70%)
            Consumer<SigninFormProvider>(
              builder: (context, provider, _) {
                return SizedBox(
                  width: buttonWidth,
                  height: 48,
                  child: Container(
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary,),
                    child: ElevatedButton(
                      
                      onPressed: () async{
                        final provider = context.read<SigninFormProvider>();
                
                          final isSuccess = await provider.submit();
                
                          if (isSuccess && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainScreen()),
                            );
                          }
                      },
                      child: provider.isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text("Sign In",
                      style: TextStyle(
                        color: AppColors.surface,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),),
                      
                    ),
                  ),
                );
              }
            ),

            const SizedBox(height: 16),

            // SIGN IN LINK
            RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      // style: DefaultTextStyle.of(context).style,
                      style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textSecondary),
                      children:  [
                        
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            color: AppColors.primary
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignUpPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  )
          ],
        );
      },
    );
  }
}




class _InputField extends StatefulWidget {

  final bool isPassword;
  final String label;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const _InputField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.errorText,
    this.onChanged,
  });


  @override
  State<_InputField> createState() => _InputFieldState();
}


class _InputFieldState extends State<_InputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
      final bool hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        /// 🔹 Top Row (Label + Error)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        /// Label + *
            RichText(
              text: TextSpan(
                text: widget.label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  if (hasError)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: AppColors.error,
                      ),
                    ),
                ],
              ),
            ),

            /// Error Message
            if (hasError)
              Text(
                widget.errorText!,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),
          ],
        ),

        const SizedBox(height: 6),

        TextField(
          obscureText: widget.isPassword ? _obscureText : false,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            // labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.textPrimary,
                width: 2,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
        
            // 👇 Only show suffix icon if password field
            suffixIcon: widget.isPassword
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: SvgPicture.asset(
                      _obscureText
                      
                          ? "assets/icons/Vector-2.svg"   // your icon 1
                          : "assets/icons/Vector.svg",    // your icon 2
                      width: 12,
                      height: 12,
                    ),
                  )
                : null,
          ),
        ),
      
        const SizedBox(height: 5),
      ],
    );
  }
}
