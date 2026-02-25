import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {

  // 🔹 Selected Date
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  // 🔹 Selected Time Slot
  String? _selectedTimeSlot;
  String? get selectedTimeSlot => _selectedTimeSlot;



  Map<String, List<String>> _bookedSlots = {"2026-02-26": ["09:00", "12:00"]}; 
  Map<String, List<String>> get bookedSlots => _bookedSlots;
  // Example:
  // {
  //   "2026-02-24": ["10:00", "11:30"]
  // }

  // ----------------------------
  // Select Date
  // ----------------------------
  void selectDate(DateTime date) {
    _selectedDate = date;

    // Reset selected time when date changes
    _selectedTimeSlot = null;

    notifyListeners();
  }


  // ----------------------------
  // Select Time Slot
  // ----------------------------
  void selectTimeSlot(String slot) {
    _selectedTimeSlot = slot;
    notifyListeners();
  }


  // ----------------------------
  // Check If Slot Is Booked
  // ----------------------------
  bool isSlotBooked(String dateKey, String slot) {
    return _bookedSlots[dateKey]?.contains(slot) ?? false;
  }

  // ----------------------------
  // Set Booked Slots (From API)
  // ----------------------------
  void setBookedSlots(Map<String, List<String>> slots) {
    _bookedSlots = slots;
    notifyListeners();
  }

}