import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/models/doctor_chat_model.dart';

class DoctorChatScreen extends StatelessWidget {
  final DoctorChatModel doctor;

   const DoctorChatScreen({
    super.key, required this.doctor
   
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(child: 
      Center(child: Text('CHAT SCREEN'))),
    );
  }
  }