
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/core/theme/app_text_styles.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/models/option_models.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/start_4.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';

class StartPage3 extends StatefulWidget{
  const StartPage3({super.key});
  
  @override
  State<StartPage3> createState() => StartPage3State();
}


class StartPage3State extends State<StartPage3>{

  final List<OptionModel> options = [
    OptionModel(role: UserRole.patient, label: "I'm a Patient", iconPath: 'assets/icons/icon patient.svg', description: "Proin convallis libero ac nisl "),
    OptionModel(role: UserRole.doctor, label: "I'm a Doctor", iconPath: 'assets/icons/icon doctor.svg', description: "Proin convallis libero ac nisl "),
  ];

  @override
  Widget build (BuildContext context){

    final userRoleProvider = context.watch<UserRoleProviders>(); // from auth_provider.dart

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 🔹 Logo
              Image.asset(
                'assets/images/logo medicine 1 4 5.png',
                height: 120,
              ),
          
              SizedBox(height: 30,),
          
              // Heading
              Text(
                "Let's get acquainted",
                style: AppTextStyles.heading,
                textAlign: TextAlign.center,
              ),
          
              SizedBox(height: 12,),
          
              Text(
                "Pellentesque placerat arcu in risus facilisis, sed laoreet eros laoreet.",
                style: AppTextStyles.subHeading2,
                textAlign: TextAlign.center,
              ),
          
              SizedBox(height: 70,),
          
              /// 🔥 Dynamic Radio Options
              ...List.generate(options.length, (index) {
                final selectedOption = options[index];
                final selectedRole = userRoleProvider.selectedUserRole == selectedOption.role;
          
                return GestureDetector(
                  onTap: () {
                    // setState(() {                  // need to convert to PROVIDER
                    //   selectedIndex = index;
                    // });
                    context
                        .read<UserRoleProviders>()
                        .userRoleSelection(selectedOption.role);
                  
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //   color: AppColors.background,
                      //   width: 1.5,
                      // ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedRole
                                ? AppColors.primary
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset(
                            options[index].iconPath,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              selectedRole ? AppColors.surface : AppColors.textPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                options[index].label,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      selectedRole ? AppColors.primary : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                options[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:AppColors.textSecondary,
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          
              Spacer(),
          
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 200,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // logic
                    final role = context.read<UserRoleProviders>().selectedUserRole;

                    // if (role == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text("Please select a role")),
                    //   );
                    //   return;
                    // }

                    switch (role) {
                      case UserRole.patient:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StartPage4(),
                          ),
                        );
                        break;

                      case UserRole.doctor:
                        // Doctor flow not ready yet
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Doctor flow coming soon")),
                        );
                        break;
                    }
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
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          
            ],
          ),
        )
      )

    );
  }

}