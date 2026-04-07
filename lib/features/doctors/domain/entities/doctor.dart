

class Doctor {
  final String id;
  final String photo;
  final String name;
  final String department;
  final double rating;
  final int reviews;
  final int fee;
  final String consultationDate;
  final String consultationTime;
  final String description;
  final String location;
  final String hospital;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final List<String> tags;

  Doctor({
    required this.id,
    required this.photo,
    required this.name,
    required this.department,
    required this.rating,
    required this.reviews,
    required this.fee,
    required this.consultationDate,
    required this.consultationTime,
    required this.description,
    required this.location,
    required this.hospital,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    required this.tags,
  });
}