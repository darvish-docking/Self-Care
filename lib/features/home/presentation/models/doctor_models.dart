import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfcare_mobileapp/features/doctors/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.photo,
    required super.name,
    required super.department,
    required super.rating,
    required super.reviews,
    required super.fee,
    required super.consultationDate,
    required super.consultationTime,
    required super.description,
    required super.location,
    required super.hospital,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
    required super.isOnline,
    required super.tags,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      id: doc.id,
      photo: data['photo'] ?? '',
      name: data['name'] ?? '',
      department: data['department'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviews: data['reviews'] ?? 0,
      fee: data['fee'] ?? 0,
      consultationDate: data['consultationDate'] ?? '',
      consultationTime: data['consultationTime'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      hospital: data['hospital'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: data['lastMessageTime'] != null 
          ? (data['lastMessageTime'] as Timestamp).toDate() 
          : DateTime.now(),
      unreadCount: data['unreadCount'] ?? 0,
      isOnline: data['isOnline'] ?? false,
      tags: List<String>.from(data['tags'] ?? []),
    );
  }
}
