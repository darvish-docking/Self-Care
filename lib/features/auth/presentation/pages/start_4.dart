import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/core/theme/app_text_styles.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/pages/signup.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';

class StartPage4 extends StatefulWidget{
  const StartPage4({super.key});

  @override
  State<StartPage4> createState() => StartPage4State();
}


class StartPage4State extends State<StartPage4>{

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
               SizedBox(height: screenheight * 0.01),

              /// 🔹 Header Section (Centered)
              _buildHeader(context),

              const SizedBox(height: 60),

              /// 🔹 Form Section (Left aligned)
              _buildFormSection(context),

               SizedBox(height: screenheight * 0.03),

              /// 🔹 Button (Centered)
              Center(
                child: _buildContinueButton(context),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );

  }
}




Widget _buildHeader(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          'assets/images/logo medicine 1 4 5.png',
          height: 60,
        ),
      ),
       SizedBox(height: screenheight *0.01),
      Center(
        child: Text(
          "A little about yourself",
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 12),
      Center(
        child: Text(
          "Ed laoreet eros laoreet.",
          style: AppTextStyles.subHeading2,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}


Widget _buildFormSection(BuildContext context){

  final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

  
  return Column(children: [

    //gender
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your gender",
        style: AppTextStyles.label,),
        const SizedBox(height: 12),
        
        Row(
          children: Gender.values.map((gender) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: gender != Gender.values.last ? 12 : 0,),
                child: _genderOption(context, gender),
              ),
            );
          }).toList(),
        ),
      ],
    ),

     SizedBox(height: screenheight * 0.02),

    // birthday
    Consumer<SignupFormProvider>(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your birthday",
                style: AppTextStyles.label,),
            const SizedBox(height: 12),]),

      builder: (context, dob, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child!, // Static part won't rebuild
            Row(
              children: [
                Flexible(child: _dateField(context, hint: "DD", controller: dob.dayController,
                      focusNode: dob.dayFocus,
                      nextFocus: dob.monthFocus,
                      errorText: dob.dayError,)),
                const SizedBox(width: 12),
                Flexible(child: _dateField(context, hint: "MM",
                controller: dob.monthController,
                      focusNode: dob.monthFocus,
                      nextFocus: dob.yearFocus,
                      errorText: dob.monthError,)),
                const SizedBox(width: 12),
                Flexible(child: _dateField(context, hint: "YYYY",
                controller: dob.yearController,
                      focusNode: dob.yearFocus,
                      nextFocus: null,
                      errorText: dob.yearError,)),
              ],
            ),
          ],
        );
      }
    ),

    SizedBox(height: screenheight * 0.02),


    //location
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Your location",
          style: AppTextStyles.label,),

      const SizedBox(height: 12),

      Consumer<SignupFormProvider>(
        builder: (context, loc, child) {
          final hasError = loc.countryError != null;

          return Column(
            children: [
              TextField(
                readOnly: true,
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      loc.setCountry(country);
                    },
                  );
                },
                decoration: InputDecoration(
                  hintText: "Enter your city",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: loc.countryError,

                  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: hasError
            ? AppColors.error
            : AppColors.textPrimary,
      ),
    ),

    // 👇 Focused border
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: hasError
            ? AppColors.error
            : AppColors.primary,
        width: 2,
      ),
    ),

    // 👇 When error is present (not focused)
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.error,
      ),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),

    // 👇 Custom error text style
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 13,
    ),

              
                  prefixIcon: loc.selectedCountry != null
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.background,
                            child: Text(
                              loc.selectedCountry!.flagEmoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      : const Icon(Icons.public),
              
                  suffixIcon: 
                  Padding(
                    padding: const EdgeInsets.only(right:4.0),
                    child: 
                    Container(
                      
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                      child: const Icon(Icons.arrow_drop_down)),
                  ),
                ),
                controller: TextEditingController(
                  text: loc.selectedCountry?.name ?? "",
                ),
              ),
            ],
          );
        }
      ),
    ],
  ),

  SizedBox(height: screenheight * 0.02),
  
  ]
  );
}


Widget _buildContinueButton(context) {
  return SizedBox(
    width: 250,
    child: Consumer<SignupFormProvider>(
      builder: (context, formProvider, child) {
        return ElevatedButton(
          onPressed: () {
            //gender + dob + location

            // print('role: ${formProvider.selectedUserRole.name} - gender: ${formProvider.selectedGender?.label} - DOB: ${formProvider.selectedDob} - Location: ${formProvider.selectedCountry}');
            if (!formProvider.validateOnContinue()) {
              print("Validation failed");
              return;
            }

            
            Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
        
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text("Continue"),
        );
      }
    ),
  );
}









Widget _genderOption(BuildContext context, Gender gender) {
  // final selectedGender =
  //     context.watch<GenderProviders>().selectedGender;

  final isSelected = context.select<SignupFormProvider, bool>(
  (provider) => provider.selectedGender == gender,
);

  // final isSelected = selectedGender == gender;

  final icon = gender.iconPath;
  final label = gender.label;

  return GestureDetector(
    onTap: () {
      context.read<SignupFormProvider>().selectGender(gender);
    },
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:AppColors.cardBackground,
        ),
      ),
      // alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 12,
      ),
      
      child: Row(
        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:isSelected ? AppColors.primary : AppColors.surface,
              ),
            ),
            alignment: Alignment.center,
              child: SvgPicture.asset(
                icon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  isSelected? AppColors.surface : AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textPrimary,
                ),
                
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



Widget _dateField(BuildContext context, {required String hint, required TextEditingController controller, required FocusNode focusNode, 
required FocusNode? nextFocus, String? errorText} ) {

  final hasError = errorText != null;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hint == 'DD'? 'Day:': hint == 'MM'? 'Month:' : 'Year:',
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 15.0,
        fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.left,),
      SizedBox(
        width: 80,
        height: 50,
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          controller: controller,
          focusNode: focusNode,
          maxLength:  hint == "YYYY" ? 4 : 2,
          inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
          decoration: InputDecoration(
            counterText: "",
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14),

            // ✅ Dynamic border color
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError
                    ? AppColors.error
                    : AppColors.textPrimary,
                    width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError
                    ? AppColors.error
                    : AppColors.primary,
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
          context.read<SignupFormProvider>().onChanged();

          if (controller.text.length == (hint == "YYYY" ? 4 : 2) && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
            },
        ),
      ),
      SizedBox(
  height: 18,
  child: AnimatedOpacity(
    duration: const Duration(milliseconds: 200),
    opacity: hasError ? 1.0 : 0.0,
    child: Text(
      errorText ?? '',
      style: const TextStyle(
        color: AppColors.error,
        fontSize: 13,
      ),
    ),
  ),
),
      
    ],
  );
}
