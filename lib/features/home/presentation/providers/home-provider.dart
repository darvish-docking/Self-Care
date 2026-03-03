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
    id: '1',
    photo: 'assets/images/Dr.Marvin Mckinney.png',
    name: "Dr.Marvin Mckinney",
    department: "Nephrologist",
    rating: 4.1,
    reviews: 22,
    fee: 80,
    description: "Dr.Marvin is experienced in managing kidney-related disorders such as chronic kidney disease, kidney infections, electrolyte imbalances, and hypertension-related renal complications. The approach includes accurate diagnosis, personalized treatment plans, and patient education to help maintain optimal kidney function and prevent long-term complications.",
    location: "3891 Ranchview,San Francisco 62639",
    hospital: "International Medical College",
    lastMessage: "Please continue the medication for 7 days.",
    lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 2,
    isOnline: true,
    consultationDate: "23 May 2026",
    consultationTime: "10:00",
    tags: ['nephrologist'],
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
  }
}