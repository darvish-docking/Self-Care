import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/payment.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/providers/bookAppointment-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';

class ThankyouScreen extends StatefulWidget {
  final DoctorModel doctor;
  const ThankyouScreen({super.key, required this.doctor});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}


class _ThankyouScreenState extends State<ThankyouScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      /// ✅ Reuse your existing Bottom Navigation
      bottomNavigationBar: const BottomNavBar(), // Replace with your bottom nav widget
      body: Column(
        children: [

          /// =========================
          /// 🔵 TOP GREEN SECTION
          /// =========================
          SizedBox(
            height: height * 0.35,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),

                /// Back Button
                Positioned(
                  top: 50,
                  left: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset("assets/icons/left arrow white.svg",
                            width: 10,
                            height: 10,),
                            onPressed: () => Navigator.pop(context),
                            color: AppColors.surface,
                          ),
                          const Text(
                            "Back",
                            style: TextStyle(fontSize: 16, color: AppColors.surface),
                          ),
                          Image.asset(
                          'assets/images/Logo.png',
                          height: 60,
                        ),
                        ],
                      ),
                ),

                /// Center Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    
                    SizedBox(height: 80),
                    Text(
                      "Thank you!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.surface,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary, // Green background
                        border: Border.all(
                          color: AppColors.surface,   // White circumference
                          width: 3,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: AppColors.surface,   // White check mark
                          size: 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your visit has been successfully reserved, please pay for it to get an appointment with the selected doctor",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// =========================
          /// ⚪ BOTTOM SECTION
          /// =========================
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Doctor Tile
                  Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6)
                ],
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CircleAvatar(radius: 30),
                  SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            widget.doctor.photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(widget.doctor.name,
                    style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          Text(widget.doctor.department),
                        ],
                      ),
                    ),
                  ),
                  Row(
          children: [
        Text(
          "(${widget.doctor.reviews} reviews)",
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.star,
          size: 18,
          color: Color.fromARGB(255, 247, 142, 177),
        ),
        const SizedBox(width: 4),
        Text(
          widget.doctor.rating.toString(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
          ],
        )
                ],
              ),
            ),
     
                  const SizedBox(height: 20),

                  /// Appointment Details
                  // _detailRow("Date", "24 Feb 2026"),
                  // _detailRow("Time", "10:30 AM"),
                  // _detailRow("Location", "International Medical College"),
                  // _detailRow("Consultation Fee", "₹ 800"),

                  // Date and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                      "Date: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                          textAlign: TextAlign.left,
                    ),
                    Consumer<AppointmentProvider>(
                      builder: (context, date, _) {
                        String formattedDate =
    DateFormat('dd MMM yyyy').format(date.selectedDate);
                        return Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary),
                              textAlign: TextAlign.left,
                        );
                      }
                    ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                      "Time: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                          textAlign: TextAlign.left,
                    ),
                     Consumer<AppointmentProvider>(
                       builder: (context, time, _) {
                         return Text(
                          time.selectedTimeSlot!,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary),
                              textAlign: TextAlign.left,
                                             );
                       }
                     ),
                        ],
                      )
                    ],
                  ),


                  SizedBox(height: height * 0.05),
                  // Location
                  const Text(
                      "Location: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                          textAlign: TextAlign.left,
                    ),

                    SizedBox(height: height * 0.01),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            SvgPicture.asset(
                              "assets/icons/location.svg",
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                              
                            ),
                            SizedBox(width: width * 0.01),
                            Expanded(
                              child: Text(
                                widget.doctor.location,
                                style: TextStyle(
                                    color: AppColors.textSecondary,
                                    ),
                                    // softWrap: true,
                              ),
                            ),
                            
                          ],),
                        ),

                        SizedBox(width: width * 0.1),

                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Align(
                              alignment: AlignmentGeometry.topLeft,
                              child: SvgPicture.asset(
                              "assets/icons/hospital.svg",
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                              
                                                        ),
                            ),
                          SizedBox(width: width * 0.01),
                          Expanded(
                            child: Text(
                              widget.doctor.hospital,
                              style: TextStyle(
                              color: AppColors.textSecondary,
                              ),
                              // softWrap: true,
                              ),
                          )
                          
                          ],),
                        )

                      ],

                    ),
                    SizedBox(height: height * 0.05),
                  // Location
                  Row(
                    children: [
                      const Text(
                          "Cost: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary),
                              textAlign: TextAlign.left,
                        ),
                        Text('\$${widget.doctor.fee}',
                        style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary)
                        )
                    ],
                  ),


                  SizedBox(height: height * 0.04),

                  /// Button
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen()));},
                        child: const Text("Go to payment"),
                      ),
                    ),
                  ),

                   SizedBox(height: height * 0.006),

                  Center(
                    child: TextButton(
                      onPressed: () {
                          // Your action here
                        },
                      child: Text("Cancel reservation",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey,
                      fontSize: 16),)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // static Widget _detailRow(String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(title, style: const TextStyle(color: Colors.grey)),
  //         Flexible(
  //           child: Text(
  //             value,
  //             textAlign: TextAlign.right,
  //             style: const TextStyle(fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


}