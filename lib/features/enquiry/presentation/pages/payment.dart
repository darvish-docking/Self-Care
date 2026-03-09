import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/providers/payment_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';

class PaymentScreen extends StatefulWidget {
  // final DoctorModel doctor;
  const PaymentScreen({super.key, 
  // required this.doctor
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethods {
  paypal, creditCard
}

class _PaymentScreenState extends State<PaymentScreen> {
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      /// ✅ Reuse your existing Bottom Navigation
      // bottomNavigationBar: const BottomNavBar(), // Replace with your bottom nav widget
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: SvgPicture.asset("assets/icons/left arrow.svg",
                    width: 15,
                    height: 15,),
                    onTap: () => Navigator.pop(context),
                  ),
                  const Text(
                    " Back",
                    style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                  ),
                ],
              ),
              
              SizedBox(height: height * 0.02),
          
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                    "Payment Options",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary
                    ),
                  ),
              ),

              Column(
                children: [
                  _buildPaymentTile(
                    title: "PayPal",
                    prefixicon: '',
                    svgPath: 'assets/icons/icon paypal.svg',
                    value: PaymentMethods.paypal,
                  ),
                  _buildPaymentTile(
                    title: "Credit Card",
                    prefixicon: 'assets/icons/creditCard.svg',
                    svgPath: 'assets/icons/Visa.svg',
                    value: PaymentMethods.creditCard,
                  ),
                ],
              ),

              Spacer(),

              Center(
                    child: SizedBox(
                      width: width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Pay"),
                      ),
                    ),
                  ),
            ]
          ),
        ),
      )
    );
  }
}






Widget _buildPaymentTile({
  required String title,
  required String prefixicon,
  required String svgPath,
  required PaymentMethods value,
}) {
  return Consumer<PaymentProvider>(
    builder: (context, provider, child) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
      final bool isSelected = provider.selectedPayment == value;

      return GestureDetector(
        onTap: () {
          provider.selectPayment(value);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [

              /// Rounded Checkbox
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),

             SizedBox(width: width * 0.04),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary
                  ),
                ),
              ),

              SizedBox(width: width * 0.2),

              SvgPicture.asset(
                prefixicon,
                height: 26,
                width: 26,
                // colorFilter: const ColorFilter.mode(
                //   Colors.red,
                //   BlendMode.srcIn,
                // ),
              ),

              SvgPicture.asset(
                svgPath,
                height: 26,
                width: 26,
                // color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      );
    },
  );
}
  