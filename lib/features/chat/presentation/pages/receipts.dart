import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/models/receipts_model.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Temporary dummy data (Later replace with Provider/API)
    final List<DoctorReceiptModel> receipts = [
      DoctorReceiptModel(
        name: "Dr.Jacob Jones",
        department: "Cardiologist",
        image: "assets/images/Dr.Jacob Jones.png",
        medicines: [
          MedicineModel(
        name: "Cetirizine 15mg",
        instructions: "Once daily after food",
      ),
        ],
        notes: [
          "Regular exercise for minimum of one hour daily.",
          "Avoid direct sunlight exposure",
        ],
      ),
      DoctorReceiptModel(
        name: "Dr.Eleanor Pena",
        department: "Pediatrics",
        image: "assets/images/Dr.Eleanor Pena.png",
        medicines: [
          MedicineModel(
        name: "lopamide 5mg",
        instructions: "Once daily after food",
      ),
      MedicineModel(
        name: "Ascoril",
        instructions: "Night before sleep",
      ),
        ],
        notes: [
          "Avoid oily food",
          "Reduce screen time.",
        ],
      ),
      
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔙 Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    IconButton(
                  icon: SvgPicture.asset("assets/icons/left arrow.svg",
                  width: 15,
                  height: 15,),
                  onPressed: () => Navigator.pop(context),
                ),
                    SizedBox(width: width * 0.01),
                    const Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              /// 🧾 Heading
              Text(
                "Receipts",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary
                ),
              ),

              SizedBox(height: height * 0.03),

              /// 📋 Doctor Receipts List
              Expanded(
                child: ListView.builder(
                  itemCount: receipts.length,
                  itemBuilder: (context, index) {
                    return DoctorReceiptCard(
                      doctor: receipts[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DOCTOR RECEIPT CARD
////////////////////////////////////////////////////////////

class DoctorReceiptCard extends StatelessWidget {
  final DoctorReceiptModel doctor;

  const DoctorReceiptCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 👨‍⚕️ Doctor Info
          Row(
            children: [
              Container(
                width: width * 0.12,
                height: width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(doctor.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: width * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doctor.department,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 💊 Medicines (Each Separate Container)
          ...doctor.medicines.map(
            (medicine) => ReceiptItemContainer(
              name:medicine.name,
              content: medicine.instructions,
            ),
          ),

          /// 📝 Notes (Each Separate Container)
          ...doctor.notes.map(
            (note) => NoteContainer(
              note: note,
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// INDIVIDUAL RECEIPT ITEM CONTAINER
////////////////////////////////////////////////////////////

class ReceiptItemContainer extends StatelessWidget {
  final String content;
  final String name;

  const ReceiptItemContainer({
    super.key,
    required this.content, required this.name
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(width * 0.035),
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 153),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset('assets/icons/pills.svg',
              width: width * 0.04,
              height: height * 0.04,
              colorFilter: ColorFilter.mode(
                                            AppColors.surface,
                                            BlendMode.srcIn,
                                          ),
            ),
          ),

          SizedBox(width: width * 0.04),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(width: width * 0.04),
          
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.04,
                  color: Colors.black87,
                
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class NoteContainer extends StatelessWidget {
  final String note;

  const NoteContainer({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        note,
        style: TextStyle(
          fontSize: width * 0.038,
          color: Colors.black87,
        ),
      ),
    );
  }
}