enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
}

class ChatMessage {
  final String id;
  final String message;
  final DateTime time;
  final bool isMe;
  final MessageStatus status;

  ChatMessage({
    required this.id,
    required this.message,
    required this.time,
    required this.isMe,
    required this.status,
  });
}