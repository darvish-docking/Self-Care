import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/book_appointment.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/doctor_one.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/category_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/filter_tag_model.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/data_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/home-provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/widgets/bottom_nav_bar.dart';


class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // final homeProvider = context.watch<HomeProvider>();

  WidgetsBinding.instance.addPostFrameCallback((_) {

  final homeProvider = context.read<HomeProvider>();
  final dataProvider = context.read<DataProvider>();

  // Reset previous state
  homeProvider.clearFilters();

  // Reload base data
  homeProvider.updateData(dataProvider);

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
              return _buildCategoryCard(category, context);
            }).toList(),
          ),
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
            border: Border.all(
              color: isSelected ? AppColors.doctor : Colors.transparent,
              width: 2,
            ),
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
        const Text("All",
            style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        
        const SizedBox(height: 4),
        
        Consumer<HomeProvider>(
          builder: (context, doctor, _) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // important if inside another scroll
              itemCount: doctor.doctors.length,
              itemBuilder: (context, index) {
                final selectedDoctor = doctor.doctors[index];
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





