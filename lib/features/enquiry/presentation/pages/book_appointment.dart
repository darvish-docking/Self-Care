import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/models/doctorConsultation_model.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/providers/bookAppointment-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/pages/home.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';

class BookAppointmentScreen extends StatefulWidget {
  final DoctorConsultation doctor;
  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}



class _BookAppointmentScreenState
    extends State<BookAppointmentScreen> {

  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  final List<String> timeSlots = [
    "09:00",
    "10:30",
    "12:00",
    "14:00",
    "16:30",
    "18:00",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.white,

      /// ✅ Reuse your existing Bottom Navigation
      bottomNavigationBar: const BottomNavBar(), // Replace with your bottom nav widget

      body: Column(
        children: [
          Container(
            /// 🔝 Top SafeArea with color
            color: AppColors.surface,
            height: MediaQuery.of(context).padding.top
          ),
            Expanded(
              child: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(
                //     horizontal: size.width * 0.05,
                //     vertical: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                          
                    Container(
                      padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.001),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: AppColors.surface,
                      ),
                      child: Column(
                        children: [
                        
                      /// ==============================
                      /// 🔝 TOP SECTION
                      /// ==============================
                      
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
                      
                      SizedBox(height: size.height * 0.02),
                      
                      /// Doctor Info Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          /// Doctor Image + Rating
                          Stack(
                            children: [
                              Container(
                                width: size.width * 0.25,
                                height: size.width * 0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey.shade300,
                                  image: DecorationImage(
                                    image: AssetImage(widget.doctor.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                            
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:  Row(
                                    children: [
                                      const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Color.fromARGB(255, 247, 142, 177),
                                        ),
                                      Text(
                                        '${widget.doctor.rating}',
                                        style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                      
                          SizedBox(width: size.width * 0.04),
                      
                          /// First Column (Doctor Name + Dept + Buttons)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                      
                                 Text(
                                  widget.doctor.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                                ),
                      
                                const SizedBox(height: 4),
                      
                                 Text(
                                  widget.doctor.department,
                                  style: TextStyle(
                                      color: Colors.grey),
                                ),
                      
                                SizedBox(height: size.height * 0.015),
                      
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                      
                                        },
                                        icon: SvgPicture.asset('assets/icons/messages.svg',
                                          colorFilter: ColorFilter.mode(
                                            AppColors.surface,
                                            BlendMode.srcIn,
                                          ),),
                                        style: IconButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            fixedSize: const Size(40, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),)
                                        ),
                                    
                                    IconButton(
                                        onPressed: () {
                      
                                        },
                                        icon: SvgPicture.asset('assets/icons/call.svg',
                                        colorFilter: ColorFilter.mode(
                                          AppColors.surface,
                                          BlendMode.srcIn,
                                        ),),
                                        style: IconButton.styleFrom(
                                            backgroundColor: AppColors.doctor,
                                            fixedSize: const Size(40, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),)),
                                  ],
                                )
                              ],
                            ),
                          ),
                      
                          /// Second Column (More + Fee)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset('assets/icons/icon Ellipses.svg')),
                      
                              const SizedBox(height: 20),
                      
                               Text(
                                "\$${widget.doctor.fee}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, color: AppColors.textPrimary, fontSize: 25),
                              ),
                            ],
                          )
                        ],
                      ),
                      
                      SizedBox(height: size.height * 0.03),
                      
                        
                        ],
                      ),
                    ),
                          
                    /// ==============================
                    /// 🟢 MIDDLE SECTION
                    /// ==============================
                          
                    Container(
                      padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                      
                    /// Cancel Visit Container
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children:  [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Cancel a Visit",
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/icons/right arrow.svg",
                              width: 18,
                              height: 18,
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/icons/right arrow.svg",
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                AppColors.surface,
                                BlendMode.srcIn,
                              ),
                              
                            ),
                          ),
                            ],
                          )
                          
                        ],
                      ),
                    ),
                          
                    SizedBox(height: size.height * 0.03),
                          
                    /// Stats Row
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatItem(title: "Patients", value: "+423"),
                        _StatItem(title: "Experiences", value: "+8 years"),
                        _StatItem(title: "Ratings", value: "4.8"),
                      ],
                    ),
                          
                    SizedBox(height: size.height * 0.04),
                          
                    /// Schedule Section
                    const Text(
                      "Schedule",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                          
                    SizedBox(height: size.height * 0.02),
                          
                    /// Date Selector
                    SizedBox(
                      height: 70,
                      child: Consumer<AppointmentProvider>(
                        builder: (context, appointment, _) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 14,
                            itemBuilder: (context, index) {
                              
                              final date =
                                  DateTime.now().add(Duration(days: index));
                              
                              final isSelected =
            appointment.selectedDate.day == date.day &&
            appointment.selectedDate.month == date.month &&
            appointment.selectedDate.year == date.year;
                              
                              return GestureDetector(
                                onTap: () {
                                  appointment.selectDate(date);
                                },
                                child: Container(
                                  width: 80,
                                  margin:
                                      const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${date.day}",
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.surface
                                              : AppColors.textPrimary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        DateFormat.MMM().format(date),
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.surface
                                              : AppColors.textSecondary,
                                              fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      ),
                    ),
                          
                    SizedBox(height: size.height * 0.03),
                          
                    /// Time Section
                    const Text(
                      "Time",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                          
                    SizedBox(height: size.height * 0.02),
                          
                    Consumer<AppointmentProvider>(
                      builder: (context, appointment, _) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(timeSlots.length,
                              (index) {
                              
                            final dateKey =
                              DateFormat('yyyy-MM-dd').format(appointment.selectedDate);

                            final isBooked =
                                appointment.isSlotBooked(dateKey, timeSlots[index]);

                            final isSelected =
                                appointment.selectedTimeSlot == timeSlots[index];

                              
                            return GestureDetector(
                              onTap: isBooked
                                ? null
                                : () => appointment.selectTimeSlot(timeSlots[index]),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isBooked
                                    ? AppColors.cardBackground
                                    : isSelected
                                      ? AppColors.primary
                                      : AppColors.surface,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  
                                ),
                                child: Text(
                                  timeSlots[index],
                                  style: TextStyle(
                                    color: isBooked
                                      ? AppColors.textSecondary
                                      : isSelected
                                        ? AppColors.surface
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    ),
                          
                    SizedBox(height: size.height * 0.04),
                          
                    /// About Section
                    const Text(
                      "About Doctor",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                          
                    const SizedBox(height: 10),
                          
                     Text(
                      widget.doctor.description,
                      style: TextStyle(
                          color: Colors.grey,
                          height: 1.5),
                    ),
                          
                    SizedBox(height: size.height * 0.05),
                          
                    ],),
                    )
                  ],
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}

/// Stat Item Widget
class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return Column(
      children: [
        
        Text(
          title,
          style: const TextStyle(
              color: AppColors.textSecondary, fontSize: 15),
        ),
        const SizedBox(height: 4),
        Container(
          width: size.width*0.25,
          height: size.height*0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.border
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
          ),
        ),
        
      ],
    );
  }
}