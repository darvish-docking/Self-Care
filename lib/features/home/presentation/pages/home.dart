import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/providers/app_providers.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/book_appointment.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/doctor_one.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/doctors.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/category_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/filter_tag_model.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/data_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final homeProvider = context.watch<HomeProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeProvider.doctors.isEmpty) {
        final dataProvider = context.read<DataProvider>();
        homeProvider.updateData(dataProvider);
      }
    });

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.12,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              top: screenHeight * 0.05,
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(),
                SizedBox(height: 12),
                LocationSection(),
                SizedBox(height: 16),
                SearchSection(),
                SizedBox(height: 16),
                FilterChipsSection(),
                SizedBox(height: 20),
                RecentSection(doctors: [],),
                SizedBox(height: 24),
                CategoriesSection(),
                SizedBox(height: 24),
                PopularDoctorsSection(),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}






class HeaderSection extends StatelessWidget {
    HeaderSection({super.key});

    final List<String> notifications = [''];


  @override
  Widget build(BuildContext context) {

    return Consumer<SignupFormProvider>(
      builder: (context, head, _) {
        return Row(
          children: [
             Expanded(
               child: Text(
                "Welcome Back, ${head.fullName}!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  
                ),
                overflow: TextOverflow.ellipsis
                           ),
             ),
            // const Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    width: 24,
                  ),
                ),

                // 🔴 Red dot (only if notifications exist)
                if (notifications.isNotEmpty)
                  Positioned(
                    right: 12,
                    top: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            )
          ],
        );
      }
    );
  }
}




class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<SignupFormProvider>(
      builder: (context,loc,child) {
        return Row(
          children: [
            const Icon(Icons.location_on_outlined, color: AppColors.textSecondary),
            // const SizedBox(width: 6),
        
             Text(
              loc.selectedCountry?.name ?? "Select location",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ]);
          }
        );
      
  }
}





class SearchSection extends StatelessWidget {
  const SearchSection({super.key});
  

  @override
  Widget build(BuildContext context,) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    final provider = context.watch<HomeProvider>();
    

    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Example "heart" ',
              hintStyle: TextStyle(
                color: AppColors.textSecondary,   // your custom hint color
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),

              filled: true,
              fillColor: AppColors.surface,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
  context.read<HomeProvider>().updateSearch(value);
}
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: provider.toggleFilter,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: provider.isFilterActive
                  ? AppColors.primary
                  : AppColors.textSecondary,
              borderRadius: BorderRadius.circular(12),

              
            ),
            
            child: SvgPicture.asset("assets/icons/filter.svg"),
          ),
        )
      ],
    );
  }
}





class FilterChipsSection extends StatefulWidget {
  const FilterChipsSection({super.key});

  @override
  State<FilterChipsSection> createState() => _FilterChipSectionState();
}

class _FilterChipSectionState  extends State<FilterChipsSection>{



  @override
  Widget build(BuildContext context) {

    final provider = context.watch<HomeProvider>();
    // final chips = ["#teeth", "#heart", "#eyes", "#cardiologist", "#ENT", "#skin", "#pediatrics", "#blood test", "#oncology", "#neurology"];
   final chips = [
    // FilterTagModel(label: "All", tag: ""),
    FilterTagModel(label: "Teeth", tag: "teeth"),
    FilterTagModel(label: "Dentist", tag: "dentist"),
    FilterTagModel(label: "Eyes", tag: "eyes"),
    FilterTagModel(label: "Opthalmologist", tag: "opthalmology"),
    FilterTagModel(label: "Heart", tag: "heart"),
    FilterTagModel(label: "Cardiologist", tag: "cardiology"),
    FilterTagModel(label: "Blood Test", tag: "blood"),
    FilterTagModel(label: "ENT", tag: "ent"),
    FilterTagModel(label: "Pediatrics", tag: "pediatrics"),
    FilterTagModel(label: "General", tag: "surgeon"),
  ];


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) {
          final isSelected = provider.selectedTag == chip.tag;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
  context.read<HomeProvider>().selectTag(chip.tag);
},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#${chip.tag}',
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  
}



class RecentSection extends StatelessWidget {
   RecentSection({super.key, required this.doctors});

  final List<DoctorModel>  doctors;
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Recent",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {


              },
              child: const Text("See all",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
            )
          ],
        ),
        const SizedBox(height: 10),
        Consumer<HomeProvider>(
          builder: (context, elena, _) {
            return Material(
              child: InkWell(
                onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => BookAppointmentScreen(doctor: recentConsultations[0]),
              //   ),
              // );
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BookAppointmentScreen(doctor: elena.doctors[6]),
              ),
            );
            },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.doctor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(         
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/Dr.Eleanor Pena.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dr. Eleanor Pena",
                                    style: TextStyle(color: AppColors.surface, fontSize: 16)),
                                SizedBox(height: 4),
                                Text("Pediatrics",
                                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                                SizedBox(height: 10),
                                ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('    (220 reviews)',
                                          style: TextStyle(
                                            fontSize: 11, color: AppColors.surface
                                          ),),
                                        // const SizedBox(width: 6),
                                         Icon(
                                          Icons.star,
                                          size: 14.5,
                                          color: Color.fromARGB(255, 247, 142, 177),
                                        ),
                                        // const SizedBox(width: 4),
                                        Text(
                                          '4.8',
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.surface),
                                        ),
                                      ],
                                    ),
                              Text('', style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/icon calendar.svg'),
                                    Text(" 12 Feb",
                                        style:
                                            TextStyle(color: Colors.white)),
                                  ],
                                ),
                                SizedBox(width: screenWidth * 0.1,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/icon time.svg'),
                                    Text(" 10:30 AM",
                                        style:
                                            TextStyle(color: Colors.white)),
                                  ],
                                ),
                                
                              ],
                            ),
                            Text("\$80",
                              style:
                                TextStyle(color: Colors.white)),

                          ],
                        ),),
                              
                      
                        
                    ],
                  ),
                ),
              ),
            );
          }
        ),

        const SizedBox(height: 10),

        Container(
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: AppColors.bloodTest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Blood test",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 4),
                    Text("Duis hendrerit ex nibh, non",
                        style: TextStyle(color: Colors.white70, fontSize: 15)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text("28 Feb",
                            style:
                                TextStyle(color: Colors.white)),
                        
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 130,
                height: 100,
                child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/Group 1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                
                      // SVG Icon 1
                      Positioned(
                        top: 20,
                        left: 40,
                        child: SvgPicture.asset(
                          "assets/icons/blood.svg",
                          width: 30,
                        ),
                      ),
                
                      // SVG Icon 2
                      Positioned(
                        bottom: 25,
                        right: 40,
                        child: SvgPicture.asset(
                          "assets/icons/blood.svg",
                          width: 15,
                        ),
                      ),

                      // SVG Icon 3
                      Positioned(
                        bottom: 25,
                        right: 100,
                        child: SvgPicture.asset(
                          "assets/icons/blood.svg",
                          width: 15,
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          ),
        )
      
      ],
    );
  }
}




class AppSvg {
  static const cardiology = "assets/icons/cardio.svg";
  static const dentist = "assets/icons/teeth.svg";
  static const ophthalmology = "assets/icons/eye.svg";
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {

    // final categories = [
    //   "Cardiologist",
    //   "Dentist",
    //   "Ophthalmologist",
    //   "Pulmonolagist",
    //   "Neurologist",
    //   "Dermatologist",
    //   "Gynacologist"
    // ];
    
    final categories = [
  CategoryModel(
    title: "Cardiologist",
    iconPath: AppSvg.cardiology,
    backgroundColor: const Color.fromARGB(255, 248, 208, 192),
  ),
  CategoryModel(
    title: "Dentist",
    iconPath: AppSvg.dentist,
    backgroundColor: const Color.fromARGB(255, 246, 240, 184),
  ),
  CategoryModel(
    title: "Ophthalmologist",
    iconPath: AppSvg.ophthalmology,
    backgroundColor: const Color.fromARGB(255, 187, 221, 248),
  ),
];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categories",
            style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              return _buildCategoryCard(category, context);
            }).toList(),
          ),
        )
        ],
    );
  }

  Widget _buildCategoryCard(CategoryModel category, BuildContext context) {

    final selectedCategory =
    context.watch<HomeProvider>().selectedCategory;

final isSelected =
    selectedCategory == category.title.toLowerCase();

    return SizedBox(
      width: 150,
    child: GestureDetector(
      onTap: (){
        context.read<HomeProvider>().selectCategory(category.title);
      },
      child: AspectRatio(
        aspectRatio: 1.2,  // width : height ratio
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          width: 120,
          decoration: BoxDecoration(
            color: isSelected ? category.backgroundColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
    color: isSelected ? AppColors.doctor : Colors.transparent,
    width: 2,
  ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
              )
            ],
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: category.backgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    category.iconPath,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: Text(
                    category.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12,color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                    maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      
      ),
    )
    );
  }

}




class PopularDoctorsSection extends StatelessWidget {
  const PopularDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Popular Doctors",
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorPage()));
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DoctorPage()));
                },
                child: const Text("See All",
                style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)))
          ],
        ),
        const SizedBox(height: 4),
        
        Consumer<HomeProvider>(
          builder: (context, doctor, _) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // important if inside another scroll
              itemCount: doctor.doctors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildDoctorCard(context, doctor.doctors[index]),
                );
              },
            );
          }
        ),
      
      ],
    );
  }


  Widget _buildDoctorCard(BuildContext context, DoctorModel doctor) {

    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DoctorOneScreen(doctor: doctor,))),
        child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
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
                            doctor.photo,
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
                          Text(doctor.name,
                    style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          Text(doctor.department),
                        ],
                      ),
                    ),
                  ),
                  Row(
          children: [
        Text(
          "(${doctor.reviews} reviews)",
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
          doctor.rating.toString(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
          ],
        )
                ],
              ),
            ),
      ),
    );
  }

}





