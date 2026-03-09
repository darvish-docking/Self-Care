class FilterTagModel {
  final String label;
  final String tag;

  FilterTagModel({
    required this.label,
    required this.tag,
  });
}

class TestModel {
  final String name;
  final List<String> tags;

  TestModel({
    required this.name,
    required this.tags,
  });
}

class AppointmentModel {
  final String title;
  final List<String> tags;

  AppointmentModel({
    required this.title,
    required this.tags,
  });
}