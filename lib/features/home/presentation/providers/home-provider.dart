import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/filter_tag_model.dart';
import 'package:selfcare_mobileapp/features/home/presentation/providers/data_provider.dart';


class HomeProvider extends ChangeNotifier {

  HomeProvider() {
    print("DEBUG: HomeProvider constructor called");
  }

  DataProvider? _dataProvider;




  void updateData(DataProvider dataProvider) {
  print("HomeProvider.updateData CALLED");

  _dataProvider = dataProvider;

  _allDoctors = dataProvider.doctors;

  print("Doctors received from DataProvider: ${_allDoctors.length}");

  if (_allTests.isEmpty) {
    _allTests = [
      TestModel(
        name: "Blood Test",
        tags: ["blood"],
      ),
      TestModel(
        name: "Heart Scan",
        tags: ["heart"],
      ),
    ];
  }

  if (_allAppointments.isEmpty) {
    _allAppointments = [
      AppointmentModel(
        title: "Heart Consultation",
        tags: ["heart"],
      ),
      AppointmentModel(
        title: "Dental Checkup",
        tags: ["teeth"],
      ),
    ];
  }

  _applyFilters();
}

  List<DoctorModel> get allDoctors => _dataProvider?.doctors ?? [];

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

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;



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


  void selectCategory(String category) {
    if (_selectedCategory == category) {
      _selectedCategory = ''; // toggle off
    } else {
      _selectedCategory = category.toLowerCase();
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

  // void initializeData() {

  //   _allDoctors  = allDoctors;

  //   _allTests = [
  //     TestModel(
  //       name: "Blood Test",
  //       tags: ["blood", "lab"],
  //     ),
  //     TestModel(
  //       name: "Heart Scan",
  //       tags: ["heart", "scan"],
  //     ),
  //   ];

  //   _allAppointments = [
  //     AppointmentModel(
  //       title: "Heart Consultation",
  //       tags: ["heart", "consultation"],
  //     ),
  //     AppointmentModel(
  //       title: "Dental Checkup",
  //       tags: ["teeth", "checkup"],
  //     ),
  //   ];

  //   _applyFilters();
  // }




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
      doctor.tags.any((tag) => tag.toLowerCase() == _selectedTag);

    final matchesCategory =
    _selectedCategory.isEmpty ||
    doctor.department.toLowerCase() == _selectedCategory;

    return matchesSearch && matchesTag && matchesCategory;

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


  void clearFilters() {
  _searchQuery = '';
  _selectedTag = '';
  _selectedCategory = '';

  _filteredDoctors = _allDoctors;
  _filteredTests = _allTests;
  _filteredAppointments = _allAppointments;

  notifyListeners();
}


}