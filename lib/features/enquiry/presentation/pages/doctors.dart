import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/book_appointment.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/doctor_one.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/category_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/data_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';


class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
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
                  SearchSection(),
                  SizedBox(height: 16),
                  FilterChipsSection(),
                  SizedBox(height: 20),
                  CategoriesSection(),
                  SizedBox(height: 24),
                  PopularDoctorsSection(),
                ],
              ),
            ),
          ],
        ),
        // bottomNavigationBar: const BottomNavBar(),
      ),
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
        return Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
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
                const Spacer(),
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
            ),
            Text(
                  "Doctors",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary
                  ),
                ),
          ],
        );
      }
    );
  }
}





class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context,) {

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




class FilterChipsSection extends StatelessWidget {
  const FilterChipsSection({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<HomeProvider>();
    final chips = ["#teeth", "#heart", "#eyes", "#surgeon", "#ENT", "#skin", "#pulmonology", "#blood test", "#oncology", "#neurology"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) {
          final isSelected = provider.selectedChip == chip;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => provider.selectChip(chip),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chip,
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





class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {

  
  final categories = [
  CategoryModel(
    title: "Cardiologist",
    iconPath: "assets/icons/cardio.svg",
    backgroundColor: const Color.fromARGB(255, 248, 208, 192),
  ),
  CategoryModel(
    title: "Dentist",
    iconPath: "assets/icons/teeth.svg",
    backgroundColor: const Color.fromARGB(255, 246, 240, 184),
  ),
  CategoryModel(
    title: "Ophthalmologist",
    iconPath: "assets/icons/eye.svg",
    backgroundColor: const Color.fromARGB(255, 187, 221, 248),
  ),
];

    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              return _buildCategoryCard(category);
            }).toList(),
          ),
        );
        
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return SizedBox(
      width: 150,
    child: AspectRatio(
      aspectRatio: 1.2,  // width : height ratio
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
    
    )
    );
  }

}


// final doctors = [
//   DoctorModel(
//     photo: 'assets/images/Dr.Floyd Miles.png',
//     name: "Dr. Floyd Miles",
//     department: "Pediatrics",
//     rating: 4.8,
//     reviews: 222,
//     fee: 95,
//     description: "Dr.Floyd provides comprehensive healthcare for infants, children, and adolescents. Services include routine health check-ups, immunizations, growth monitoring, and treatment of common childhood illnesses. The focus is on preventive care, early diagnosis, and ensuring healthy physical and emotional development.",
//   ),
//   DoctorModel(
//     photo: 'assets/images/Dr.Marvin Mckinney.png',
//     name: "Dr.Marvin Mckinney",
//     department: "Nephrologist",
//     rating: 4.1,
//     reviews: 22,
//     fee: 80,
//     description: "Dr.Marvin is experienced in managing kidney-related disorders such as chronic kidney disease, kidney infections, electrolyte imbalances, and hypertension-related renal complications. The approach includes accurate diagnosis, personalized treatment plans, and patient education to help maintain optimal kidney function and prevent long-term complications.",
//   ),
//   DoctorModel(
//     photo: 'assets/images/Dr.Guy Hawkins.png',
//     name: "Dr.Guy Hawkins",
//     department: "Dentist",
//     rating: 4.9,
//     reviews: 85,
//     fee: 85,
//     description: "Dr.Guy provides comprehensive dental care including routine check-ups, cavity treatment, root canal procedures, cosmetic dentistry, and preventive oral care. The focus is on maintaining oral hygiene, restoring dental health, and ensuring patient comfort through modern and minimally invasive treatment techniques.",
//   ),
//   DoctorModel(
//     photo: 'assets/images/Dr.Jane Cooper.png',
//     name: "Dr.Jane Cooper",
//     department: "Cardiologist",
//     rating: 4.7,
//     reviews: 44,
//     fee: 95,
//     description: "Dr.Jane Cooper specializes in diagnosing and treating heart-related conditions including hypertension, coronary artery disease, heart rhythm disorders, and heart failure. With extensive experience in preventive cardiology, the doctor focuses on early detection, lifestyle modification, and advanced cardiac care to ensure long-term heart health and improved quality of life for patients.",
//   ),
//   DoctorModel(
//     photo: 'assets/images/Dr.Jacob Jones.png',
//     name: "Dr.Jacob Jones",
//     department: "Nephrologyst",
//     rating: 5.0,
//     reviews: 101,
//     fee: 90,
//     description: "Dr.Jacob Jones is experienced in managing kidney-related disorders such as chronic kidney disease, kidney infections, electrolyte imbalances, and hypertension-related renal complications. The approach includes accurate diagnosis, personalized treatment plans, and patient education to help maintain optimal kidney function and prevent long-term complications.",
//   ),
//   DoctorModel(
//     photo: 'assets/images/Dr. Suvannah Nguyen.png',
//     name: "Dr. Suvannah Nguyen",
//     department: "Urologist",
//     rating: 4.8,
//     reviews: 168,
//     fee: 88,
//     description: "Dr.Suvannah specializes in diagnosing and treating urinary tract and male reproductive system disorders, including kidney stones, urinary infections, prostate conditions, and bladder dysfunction. The treatment approach emphasizes accurate evaluation, advanced medical procedures, and patient-centered care for long-term wellness.",
//   ),
// ];




class PopularDoctorsSection extends StatelessWidget {
  const PopularDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("All",
            style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        
        const SizedBox(height: 4),
        
        Consumer<DataProvider>(
          builder: (context, doctor, _) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // important if inside another scroll
              itemCount: doctor.dLength,
              itemBuilder: (context, index) {
                final selectedDoctor = doctor.doctors.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildDoctorCard(context, selectedDoctor),
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
        onTap: () => 
        // Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorOneScreen(doctor: doctor,))),
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DoctorOneScreen(doctor: doctor,))),
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





