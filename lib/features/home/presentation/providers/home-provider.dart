import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/filter_tag_model.dart';


class HomeProvider extends ChangeNotifier {

  /// -------------------------------
  /// UI STATES
  /// -------------------------------
  int _selectedBottomIndex = 0;
  bool _isFilterActive = false;

  int get selectedBottomIndex => _selectedBottomIndex;
  bool get isFilterActive => _isFilterActive;

  void changeBottomIndex(int index) {
    _selectedBottomIndex = index;
    notifyListeners();
  }

  void toggleFilter() {
    _isFilterActive = !_isFilterActive;
    notifyListeners();
  }

  /// -------------------------------
  /// SEARCH + TAG STATES
  /// -------------------------------
  String _searchQuery = '';
  String _selectedTag = '';

  String get selectedTag => _selectedTag;

  void updateSearch(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applyFilters();
  }

  void selectTag(String tag) {
    if (_selectedTag == tag) {
      _selectedTag = ''; // unselect if tapped again
    } else {
      _selectedTag = tag;
    }
    _applyFilters();
  }

  /// -------------------------------
  /// DATA LISTS
  /// -------------------------------

  List<DoctorModel> _allDoctors = [];
  List<TestModel> _allTests = [];
  List<AppointmentModel> _allAppointments = [];

  List<DoctorModel> _filteredDoctors = [];
  List<TestModel> _filteredTests = [];
  List<AppointmentModel> _filteredAppointments = [];

  List<DoctorModel> get doctors => _filteredDoctors;
  List<TestModel> get tests => _filteredTests;
  List<AppointmentModel> get appointments => _filteredAppointments;

  /// -------------------------------
  /// INITIAL DATA (Sample Data)
  /// -------------------------------

  void initializeData() {

    _allDoctors  = [
  DoctorModel(
    photo: 'assets/images/Dr.Floyd Miles.png',
    name: "Dr. Floyd Miles",
    department: "Pediatrics",
    rating: 4.8,
    reviews: 222,
    fee: 95,
    description: "Dr.Floyd provides comprehensive healthcare for infants, children, and adolescents. Services include routine health check-ups, immunizations, growth monitoring, and treatment of common childhood illnesses. The focus is on preventive care, early diagnosis, and ensuring healthy physical and emotional development.",
    location: "3891 Ranchview Dr. Richardson,San Francisco 62639",
    id: '2',
    hospital: "Jane Cooper Medical College",
    lastMessage: "Upload the latest lab report.",
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    unreadCount: 0,
    isOnline: false, 
    consultationDate: "23 MAr 2026",
    consultationTime: "16:00", 
    tags: ['children', 'pediatrics'],
  
  ),
  DoctorModel(
    id: '5',
    photo: 'assets/images/Dr.Jane Cooper.png',
    name: "Dr.Jane Cooper",
    department: "Cardiologist",
    rating: 4.7,
    reviews: 44,
    fee: 95,
    description: "Dr.Jane Cooper specializes in diagnosing and treating heart-related conditions including hypertension, coronary artery disease, heart rhythm disorders, and heart failure. With extensive experience in preventive cardiology, the doctor focuses on early detection, lifestyle modification, and advanced cardiac care to ensure long-term heart health and improved quality of life for patients.",
    location: "3891 Ranchview,San Francisco 62639",
    hospital: "Cooper loop Medical College",
    lastMessage: "How are you feeling today?",
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 5,
    isOnline: true,
    consultationDate: "23 Apr 2026",
    consultationTime: "14:00",
    tags: ['heart', 'cardiology'],
  ),
    ];

    _allTests = [
      TestModel(
        name: "Blood Test",
        tags: ["blood", "lab"],
      ),
      TestModel(
        name: "Heart Scan",
        tags: ["heart", "scan"],
      ),
    ];

    _allAppointments = [
      AppointmentModel(
        title: "Heart Consultation",
        tags: ["heart", "consultation"],
      ),
      AppointmentModel(
        title: "Dental Checkup",
        tags: ["teeth", "checkup"],
      ),
    ];

    _applyFilters();
  }

  /// -------------------------------
  /// CORE FILTER LOGIC
  /// -------------------------------

  void _applyFilters() {

    
    /// Filter Doctors
    _filteredDoctors = _allDoctors.where((doctor) {

      final matchesSearch =
          doctor.name.toLowerCase().contains(_searchQuery);

      final matchesTag =
          _selectedTag.isEmpty ||
          doctor.tags.contains(_selectedTag);

      return matchesSearch && matchesTag;

    }).toList();


    /// Filter Tests
    _filteredTests = _allTests.where((test) {

      final matchesSearch =
          test.name.toLowerCase().contains(_searchQuery);

      final matchesTag =
          _selectedTag.isEmpty ||
          test.tags.contains(_selectedTag);

      return matchesSearch && matchesTag;

    }).toList();


    /// Filter Appointments
    _filteredAppointments = _allAppointments.where((appointment) {

      final matchesSearch =
          appointment.title.toLowerCase().contains(_searchQuery);

      final matchesTag =
          _selectedTag.isEmpty ||
          appointment.tags.contains(_selectedTag);

      return matchesSearch && matchesTag;

    }).toList();

    notifyListeners();

    print("Search: $_searchQuery");
print("Tag: $_selectedTag");
print("Doctors: ${_filteredDoctors.length}");
print("Tests: ${_filteredTests.length}");
print("Appointments: ${_filteredAppointments.length}");

  }
}