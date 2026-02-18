import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/core/theme/app_text_styles.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';

class StartPage4 extends StatefulWidget{
  const StartPage4({super.key});

  @override
  State<StartPage4> createState() => StartPage4State();
}


class StartPage4State extends State<StartPage4>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 40),

              /// 🔹 Header Section (Centered)
              _buildHeader(),

              const SizedBox(height: 60),

              /// 🔹 Form Section (Left aligned)
              _buildFormSection(context),

              const SizedBox(height: 40),

              /// 🔹 Button (Centered)
              Center(
                child: _buildContinueButton(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );

  }
}




Widget _buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          'assets/images/logo medicine 1 4 5.png',
          height: 60,
        ),
      ),
      const SizedBox(height: 50),
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

    const SizedBox(height: 50),

    // birthday
    Consumer<DobProvider>(
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

    const SizedBox(height: 50),


    //location
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Your location",
          style: AppTextStyles.label,),

      const SizedBox(height: 12),

      Consumer<LocationProvider>(
        builder: (context, loc, child) {
          return TextField(
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
          );
        }
      ),
    ],
  ),

  const SizedBox(height: 70),
  
  ]
  );
}


Widget _buildContinueButton() {
  return SizedBox(
    width: 250,
    child: ElevatedButton(
      onPressed: () {
        
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text("Continue"),
    ),
  );
}









Widget _genderOption(BuildContext context, Gender gender) {
  // final selectedGender =
  //     context.watch<GenderProviders>().selectedGender;

  final isSelected = context.select<GenderProviders, bool>(
  (provider) => provider.selectedGender == gender,
);

  // final isSelected = selectedGender == gender;

  final icon = gender.iconPath;
  final label = gender.label;

  return GestureDetector(
    onTap: () {
      context.read<GenderProviders>().selectGender(gender);
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
                  fontWeight: FontWeight.w500,
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

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(hint == 'DD'? 'Day:': hint == 'MM'? 'Month:' : 'Year:',
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 15.0
        ),
        textAlign: TextAlign.left,),
      SizedBox(
        width: 80,
        height: 60,
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
            counterText: "", // hides maxLength counter
            hintText: hint,
            errorText: errorText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
          context.read<DobProvider>().onChanged();

          if (controller.text.length == (hint == "YYYY" ? 4 : 2) && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
            },
        ),
      ),
      
    ],
  );
}
