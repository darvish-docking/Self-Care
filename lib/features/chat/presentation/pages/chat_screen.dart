import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selfcare_mobileapp/core/theme/app_colors.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/models/chat_message_model.dart';
import 'package:selfcare_mobileapp/features/chat/presentation/pages/call_screen.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';

class DoctorChatScreen extends StatefulWidget {
  final DoctorModel chatWithDoctor;

  const DoctorChatScreen({
    super.key,
    required this.chatWithDoctor,
  });

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}





class _DoctorChatScreenState extends State<DoctorChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();

    /// Optional initial doctor message
    messages.add(
      ChatMessage(
        id: "1",
        message: "Hello, how can I help you today?",
        time: DateTime.now(),
        isMe: false,
        status: MessageStatus.read,
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      message: _textController.text.trim(),
      time: DateTime.now(),
      isMe: true,
      status: MessageStatus.sending,
    );

    setState(() {
      messages.add(userMessage);
    });

    _textController.clear();

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    _simulateMessageFlow(userMessage);
  }

  void _simulateMessageFlow(ChatMessage message) async {
    /// Sent
    await Future.delayed(const Duration(seconds: 1));
    _updateMessageStatus(message.id, MessageStatus.sent);

    /// Delivered
    await Future.delayed(const Duration(seconds: 1));
    _updateMessageStatus(message.id, MessageStatus.delivered);

    /// Read
    await Future.delayed(const Duration(seconds: 1));
    _updateMessageStatus(message.id, MessageStatus.read);

    /// Doctor auto reply
    await Future.delayed(const Duration(seconds: 1));
    _doctorReply();
  }

  void _updateMessageStatus(String id, MessageStatus status) {
    setState(() {
      final index = messages.indexWhere((m) => m.id == id);
      if (index != -1) {
        messages[index] = ChatMessage(
          id: messages[index].id,
          message: messages[index].message,
          time: messages[index].time,
          isMe: messages[index].isMe,
          status: status,
        );
      }
    });
  }

  void _doctorReply() {
    final reply = ChatMessage(
      id: DateTime.now().toString(),
      message: "Thank you for your message. I’ll review it.",
      time: DateTime.now(),
      isMe: false,
      status: MessageStatus.read,
    );

    setState(() {
      messages.add(reply);
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  Widget build(BuildContext context) {

      final screenWidth = MediaQuery.of(context).size.width;
  final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            /// 🔝 Top SafeArea with color
            color: AppColors.surface,
            height: MediaQuery.of(context).padding.top
          ),
        
          SizedBox(
            height: screenheight * 0.85,
            width: screenWidth,
            child: Column(
              children: [
            /// HEADER
            DoctorChatHeader(
              doctor: widget.chatWithDoctor,
              onBack: () => Navigator.pop(context),
              onCall: () {  

                // Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(callDoctor: widget.chatWithDoctor)));
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => CallScreen(callDoctor: widget.chatWithDoctor),
                  ),
                );
                // video call with DOCTOR


              },
            ),
                  
            /// CHAT LIST
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: messages[index],
                  );
                },
              ),
            ),
                  
            /// INPUT BAR
            MessageInputBar(
              controller: _textController,
              onSend: _sendMessage,
            ),
                    ]),
          )
        
        ],
      ),
    );
  }
}







class DoctorChatHeader extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onBack;
  final VoidCallback onCall;

  const DoctorChatHeader({
    super.key,
    required this.doctor,
    required this.onBack,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          /// Back
              InkWell(
                onTap: onBack,
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset("assets/icons/left arrow.svg",
                      width: 15,
                      height: 15,),
                      onPressed: () => Navigator.pop(context),
                    ),                
                    SizedBox(width: 4),
                    Text("Back", style: TextStyle(
                      color: AppColors.textPrimary
                    ),),
                  ],
                ),
              ),
          
          Row(
            children: [
          
              /// Doctor Image
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(doctor.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              const SizedBox(width: 10),
          
              /// Name + Online
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (doctor.isOnline)
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        const SizedBox(width: 5),
                        Text(
                          doctor.isOnline ? "Online" : "Offline",
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          
              /// Call Button
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.doctor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: onCall,
                  icon: const Icon(
                    Icons.call_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}







class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMe ? Alignment.centerRight : Alignment.centerLeft;

    final bubbleColor =
        message.isMe ? Colors.white : AppColors.doctor;

    final textColor =
        message.isMe ? Colors.black : Colors.white;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.time),
                  style: TextStyle(
                      fontSize: 10,
                      color: textColor.withOpacity(0.7)),
                ),
                const SizedBox(width: 4),
                if (message.isMe) _buildStatusIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (message.status) {
      case MessageStatus.sending:
        return const Icon(Icons.access_time, size: 14);
      case MessageStatus.sent:
        return const Icon(Icons.check, size: 14);
      case MessageStatus.delivered:
        return const Icon(Icons.done_all, size: 14);
      case MessageStatus.read:
        return const Icon(Icons.done_all, size: 14, color: Colors.blue);
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}





class MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            /// 🔹 FIRST SECTION (Text + Mic + Attach)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [

                    /// Text Field
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          isCollapsed: true,
                          
                        ),
                      ),
                    ),

                    /// Mic Icon
                    IconButton(
                      icon: const Icon(Icons.mic_none),
                      onPressed: () {},
                      color: AppColors.textSecondary,
                    ),

                    /// Attach Icon
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {},
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// 🔹 SECOND SECTION (Separate Send Button)
            GestureDetector(
              onTap: onSend,
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.send,
                  color: AppColors.surface,
                ),
              ),
            ),
          ],
        ),
      );
      
  }
}