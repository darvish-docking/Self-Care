import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/models/doctor_chat_model.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/pages/chat_screen.dart';





final List<DoctorChatModel> doctorList = [
  DoctorChatModel(
    id: "1",
    name: "Dr.Eleanor Pena",
    department: "Pediatrics",
    imageUrl: "assets/images/Dr.Eleanor Pena.png",
    lastMessage: "Please continue the medication for 5 days.",
    lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 2,
    isOnline: true,
  ),
  DoctorChatModel(
    id: "2",
    name: "Dr.Floyd Miles",
    department: "Pediatrics",
    imageUrl: "assets/images/Dr.Floyd Miles.png",
    lastMessage: "Upload the latest lab report.",
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    unreadCount: 0,
    isOnline: false,
  ),
  DoctorChatModel(
    id: "3",
    name: "Dr.Guy Hawkins",
    department: "Dentist",
    imageUrl: "assets/images/Dr.Guy Hawkins.png",
    lastMessage: "How are you feeling today?",
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 5,
    isOnline: true,
  ),
  DoctorChatModel(
    id: "4",
    name: "Dr.Jacob Jones",
    department: "Nephrologisy",
    imageUrl: "assets/images/Dr.Jacob Jones.png",
    lastMessage: "How are you feeling today?",
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 5,
    isOnline: true,
  ),
  DoctorChatModel(
    id: "5",
    name: "Dr.Jane Cooper",
    department: "Cardiologist",
    imageUrl: "assets/images/Dr.Jane Cooper.png",
    lastMessage: "How are you feeling today?",
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 5,
    isOnline: true,
  ),
];




class ChatMenuScreen extends StatelessWidget {
  // final DoctorChatModel chatWithDoctor;

   ChatMenuScreen({
    super.key,
    // required this.chatWithDoctor
  });

final List<String> notifications = [''];

  @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenheight = MediaQuery.of(context).size.height;


  return SafeArea(
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ---------------- HEADER ----------------
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Back + Notification Row
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/left arrow.svg",
                          width: 15,
                          height: 15,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),

                      /// Notification with red dot
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

                          if (notifications.isNotEmpty)
                            Positioned(
                              right: 10,
                              top: 6,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Chat Heading
                  const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            /// ---------------- CHAT LIST ----------------
            Expanded(
              child: ListView.builder(
                itemCount: doctorList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorList[index];

                  return DoctorChatTile(
                    doctor: doctor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DoctorChatScreen(chatWithDoctor: doctor),
                        ),
                      );
                    },
                    onCall: () {
                      print("Calling ${doctor.name}");
                    },
                  );
                },
              ),
            ),
          ],
        )
      
  );
}



}




class DoctorChatTile extends StatelessWidget {
  final DoctorChatModel doctor;
  final VoidCallback onTap;
  final VoidCallback onCall;

  const DoctorChatTile({
    super.key,
    required this.doctor,
    required this.onTap,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Dismissible(
      key: ValueKey(doctor.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async => false,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.transparent, // IMPORTANT
        child: Container(
          height: 90,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.doctor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: onCall,
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 14,
          ),
          margin: EdgeInsets.symmetric(vertical: screenHeight *0.02, horizontal: screenWidth * 0.06),
          decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(16),
  ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Doctor Image + Online Dot
              Stack(
                children: [
                  Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Rounded corners
        image: DecorationImage(
          image: AssetImage(doctor.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    ),
                  if (doctor.isOnline)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(width: screenWidth * 0.04),

              /// Right Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// First Row (Name + Time)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          _formatTime(doctor.lastMessageTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    /// Department
                    Text(
                      doctor.department,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// Second Row (Message + Unread)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            doctor.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        if (doctor.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              doctor.unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}

