import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';

class DataProvider with ChangeNotifier {
  // Private lists
  // List<Doctor> _doctors = [];
  // List<LabTest> _labTests = [];
  // List<ActivityItem> _recentActivities = [];
  

final _doctors = [
  DoctorModel(
    photo: 'assets/images/Dr.Floyd Miles.png',
    name: "Dr. Floyd Miles",
    department: "Pediatrics",
    rating: 4.8,
    reviews: 222,
    fee: 95,
    description: "Dr.Floyd provides comprehensive healthcare for infants, children, and adolescents. Services include routine health check-ups, immunizations, growth monitoring, and treatment of common childhood illnesses. The focus is on preventive care, early diagnosis, and ensuring healthy physical and emotional development.",
    location: "3891 Ranchview Dr. Richardson,San Francisco 62639",
    hospital: "Jane Cooper Medical College"
  
  ),
  DoctorModel(
    photo: 'assets/images/Dr.Marvin Mckinney.png',
    name: "Dr.Marvin Mckinney",
    department: "Nephrologist",
    rating: 4.1,
    reviews: 22,
    fee: 80,
    description: "Dr.Marvin is experienced in managing kidney-related disorders such as chronic kidney disease, kidney infections, electrolyte imbalances, and hypertension-related renal complications. The approach includes accurate diagnosis, personalized treatment plans, and patient education to help maintain optimal kidney function and prevent long-term complications.",
    location: "3891 Ranchview,San Francisco 62639",
    hospital: "International Medical College"
  ),
  DoctorModel(
    photo: 'assets/images/Dr.Guy Hawkins.png',
    name: "Dr.Guy Hawkins",
    department: "Dentist",
    rating: 4.9,
    reviews: 85,
    fee: 85,
    description: "Dr.Guy provides comprehensive dental care including routine check-ups, cavity treatment, root canal procedures, cosmetic dentistry, and preventive oral care. The focus is on maintaining oral hygiene, restoring dental health, and ensuring patient comfort through modern and minimally invasive treatment techniques.",
  location: "38991 ,San Francisco 62639",
    hospital: "Jane Luther Medical College"
    ),
  DoctorModel(
    photo: 'assets/images/Dr.Jane Cooper.png',
    name: "Dr.Jane Cooper",
    department: "Cardiologist",
    rating: 4.7,
    reviews: 44,
    fee: 95,
    description: "Dr.Jane Cooper specializes in diagnosing and treating heart-related conditions including hypertension, coronary artery disease, heart rhythm disorders, and heart failure. With extensive experience in preventive cardiology, the doctor focuses on early detection, lifestyle modification, and advanced cardiac care to ensure long-term heart health and improved quality of life for patients.",
    location: "3891 Ranchview,San Francisco 62639",
    hospital: "Cooper loop Medical College"
  ),
  DoctorModel(
    photo: 'assets/images/Dr.Jacob Jones.png',
    name: "Dr.Jacob Jones",
    department: "Nephrologyst",
    rating: 5.0,
    reviews: 101,
    fee: 90,
    description: "Dr.Jacob Jones is experienced in managing kidney-related disorders such as chronic kidney disease, kidney infections, electrolyte imbalances, and hypertension-related renal complications. The approach includes accurate diagnosis, personalized treatment plans, and patient education to help maintain optimal kidney function and prevent long-term complications.",
    location: "38291 Ranchview Dr. Richardson,San Francisco 62639",
    hospital: "Juvanine c Medical College"
  ),
  DoctorModel(
    photo: 'assets/images/Dr.Suvannah Nguyen.png',
    name: "Dr. Suvannah Nguyen",
    department: "Urologist",
    rating: 4.8,
    reviews: 168,
    fee: 88,
    description: "Dr.Suvannah specializes in diagnosing and treating urinary tract and male reproductive system disorders, including kidney stones, urinary infections, prostate conditions, and bladder dysfunction. The treatment approach emphasizes accurate evaluation, advanced medical procedures, and patient-centered care for long-term wellness.",
    location: "3891 Ranchview Dr. Richardson,San Francisco 62639",
    hospital: "Jane Cooper Medical College"
  ),
];




// Getters (UI can access these)
  List<DoctorModel> get doctors => _doctors;
  int get dLength => _doctors.length;
  // List<LabTest> get labTests => _labTests;
  // List<ActivityItem> get recentActivities => _recentActivities;
  




  // Getter for filtered/sorted lists
  // List<Doctor> get topRatedDoctors => 
  //     _doctors.where((d) => d.rating >= 4.5).toList();
  
  // List<Doctor> get availableTodayDoctors =>
  //     _doctors.where((d) => d.isAvailableToday).toList();
  
  // List<LabTest> get popularTests =>
  //     _labTests.where((t) => t.rating != null && t.rating! >= 4.0).toList();
  
  // Constructor - load mock data
  // DataProvider() {
  //   _loadMockData();
  // }





}