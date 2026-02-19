import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/otp.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary
                          ),
                        ),
                        SizedBox(height: 40),
                        _SignUpForm(),
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




class _SignUpForm extends StatelessWidget {
  const _SignUpForm();

  @override
  Widget build(BuildContext context) {
    final hasError = context.select<SignupFormProvider, bool>(
  (p) => p.showTermsError,
);
    return LayoutBuilder(
      builder: (context, constraints) {
        final fieldWidth = constraints.maxWidth * 0.9;
        final buttonWidth = constraints.maxWidth * 0.5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // FULL NAME
            // SizedBox(
            //   width: fieldWidth,
            //   child: const Text(
            //   'Full Name',
              
            //   style: const TextStyle(
            //     fontSize:14,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // ),

            // const SizedBox(height: 8),

            SizedBox(
              width: fieldWidth,
              child:  _InputField(
                label: "Full Name",
                errorText: context.select<SignupFormProvider, String?>(
                  (p) => p.fullNameError,
                ),
                onChanged:
                    context.read<SignupFormProvider>().updateFullName,
              
              ),
            ),

            // const SizedBox(height: 20),

            // EMAIL
            // SizedBox(
            //   width: fieldWidth,
            //   child: const Text(
            //     'Email',
            //     style: const TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            // const SizedBox(height: 8),

            SizedBox(
              width: fieldWidth,
              child:  _InputField(
                label: "Email",
                errorText: context.select<SignupFormProvider, String?>(
                  (p) => p.emailError,
                ),
                onChanged:
                    context.read<SignupFormProvider>().updateEmail,
              ),
            ),

            // const SizedBox(height: 20),

            // PASSWORD
            // SizedBox(
            //   width: fieldWidth,
            //   child: const Text(
            //     'Password',
            //     style: const TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            // const SizedBox(height: 8),

            SizedBox(
              width: fieldWidth,
              child:  _InputField(
                label: "Password",
                isPassword: true,
                errorText: context.select<SignupFormProvider, String?>(
                  (p) => p.passwordError,
                ),
                onChanged:
                    context.read<SignupFormProvider>().updatePassword,
              ),
            ),

            const SizedBox(height: 16),

            // CHECKBOX (LEFT ALIGNED)
            SizedBox(
              width: fieldWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Checkbox(
                    value: context.select<SignupFormProvider, bool>((p) => p.isTermsAccepted),
                    onChanged: context.read<SignupFormProvider>().toggleTerms,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                    
                    side: WidgetStateBorderSide.resolveWith((states){
                      

                      if (hasError){
                        return const BorderSide(color: AppColors.error, width: 1);
                        }
                      if (states.contains(WidgetState.selected)){
                        return const BorderSide(color: AppColors.primary, width: 1);
                      }
                      return const BorderSide(color: AppColors.textPrimary, width: 1);
                    }),

                    fillColor: WidgetStateProperty.resolveWith((states){
                      if (states.contains(WidgetState.selected)){
                        return AppColors.primary;
                      }
                      // return Colors.transparent;
                    }),
                    
                    checkColor: AppColors.surface,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(text: "I agree with Terms and ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,)),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              color: AppColors.primary
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 200),

            // SIGN UP BUTTON (70%)
            SizedBox(
              width: buttonWidth,
              height: 48,
              child: Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primary,),
                child: ElevatedButton(
                  
                  onPressed: () async{
                    final provider = context.read<SignupFormProvider>();

                      final isSuccess = await provider.submit();

                      if (isSuccess && context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OtpEnterPage(),
                          ),
                        );
                      }
                  },
                  child: const Text("Sign Up",
                  style: TextStyle(
                    color: AppColors.surface,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  
                ),
              ),
            ),

            const SizedBox(height: 16),

            // SIGN IN LINK
            GestureDetector(
              onTap: () {},
              child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(text: "Already have account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,)),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              color: AppColors.primary
                            ),
                          ),
                        ],
                      ),
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
