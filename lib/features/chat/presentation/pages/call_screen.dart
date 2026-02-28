import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/models/doctor_chat_model.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/providers/call_provider.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'chat_screen.dart';

class CallScreen extends StatefulWidget {
  DoctorModel callDoctor;
  CallScreen({super.key, required this. callDoctor});
  

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    final provider = context.read<CallProvider>();
    provider.startTimer();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation =
        Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [

          /// BACKGROUND (Doctor Video Placeholder)
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              widget.callDoctor.photo,
              fit: BoxFit.cover,
            ),
          ),

          /// DARK OVERLAY (Professional Look)
          Container(color: Colors.black.withOpacity(0.2)),

          /// CONTENT
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildCallUI(context, size, widget.callDoctor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCallUI(BuildContext context, Size size, DoctorModel callDoctor) {
    final provider = context.watch<CallProvider>();

    return Stack(
      children: [

        /// TIMER
        Positioned(
          top: size.height * 0.06,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, color: Colors.red, size: 10),
                const SizedBox(width: 6),
                Text(
                  provider.formattedTime,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),

        /// PATIENT PREVIEW
        Positioned(
          top: size.height * 0.06,
          right: 16,
          child: Column(
            children: [
              Container(
                height: size.height * 0.14,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/patient-call.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.cameraswitch, color: Colors.white),
              )
            ],
          ),
        ),

        /// DOCTOR INFO (3/4 position)
        Positioned(
          top: size.height * 0.70,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    callDoctor.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    callDoctor.department,
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),
          ),
        ),

        /// CALL CONTROLS
        Positioned(
          bottom: size.height * 0.12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              /// MIC
              _controlButton(
                icon: provider.isMicOn ? Icons.mic : Icons.mic_off,
                color: provider.isMicOn
                    ? Colors.black.withOpacity(0.6)
                    : Colors.grey,
                onTap: provider.toggleMic,
              ),

              /// END CALL
              _controlButton(
                icon: Icons.call_end,
                color: Colors.red,
                onTap: () => Navigator.pop(context),
              ),

              /// VIDEO
              _controlButton(
                icon:
                    provider.isVideoOn ? Icons.videocam : Icons.videocam_off,
                color: provider.isVideoOn
                    ? Colors.black.withOpacity(0.6)
                    : Colors.grey,
                onTap: provider.toggleVideo,
              ),
            ],
          ),
        ),

        /// SWIPE TO CHAT
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragEnd: (_) {
              Navigator.pop(context);
            },
            child: const Column(
              children: [
                Text("Swipe up to chat",
                    style: TextStyle(color: Colors.white)),
                Icon(Icons.keyboard_arrow_up, color: Colors.white),
                Icon(Icons.keyboard_arrow_up, color: AppColors.border),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _controlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}