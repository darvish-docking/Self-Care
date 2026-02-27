class DoctorChatModel {
  final String id;
  final String name;
  final String department;
  final String imageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  DoctorChatModel({
    required this.id,
    required this.name,
    required this.department,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
  });
}