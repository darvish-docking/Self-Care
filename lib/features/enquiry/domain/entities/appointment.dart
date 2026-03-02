import 'package:selfcare_mobileapp/features/enquiry/domain/enums/appointment_status.dart';

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime scheduledAt;
  final int durationMinutes;
  final AppointmentStatus status;
  final String reason;

  final String? cancelledBy;
  final String? cancellationReason;
  final DateTime? cancelledAt;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    this.cancelledBy,
    this.cancellationReason,
    this.cancelledAt,
  });
}