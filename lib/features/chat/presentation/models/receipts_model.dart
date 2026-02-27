class DoctorReceiptModel {
  final String name;
  final String department;
  final String image;
 final List<MedicineModel> medicines;
  final List<String> notes;

  DoctorReceiptModel({
    required this.name,
    required this.department,
    required this.image,
    required this.medicines,
    required this.notes,
  });
}

class MedicineModel {
  final String name;
  final String instructions;

  MedicineModel({
    required this.name,
    required this.instructions,
  });
}
