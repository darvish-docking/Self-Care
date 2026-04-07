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

  factory DoctorModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return DoctorModel(
      id: doc.id,
      photo: data['photo'],
      name: data['name'],
      department: data['department'],
      rating: (data['rating'] as num).toDouble(),
      reviews: data['reviews'],
      fee: data['fee'],
      consultationDate: data['consultationDate'],
      consultationTime: data['consultationTime'],
      description: data['description'],
      location: data['location'],
      hospital: data['hospital'],
      lastMessage: data['lastMessage'],
      lastMessageTime: (data['lastMessageTime'] as Timestamp).toDate(),
      unreadCount: data['unreadCount'],
      isOnline: data['isOnline'],
      tags: List<String>.from(data['tags']),
    );
  }
}