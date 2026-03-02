import 'package:selfcare_mobileapp/features/enquiry/domain/entities/appointment.dart';

/// Contract for appointment-related operations.
/// 
/// This repository abstracts the data source (Firestore, REST API, etc.)
/// and enforces business-level method definitions.
abstract class AppointmentRepository {
  /// Patient requests a new appointment with a doctor.
  ///
  /// Initial status: requested
  /// Payment happens after confirmation.
  Future<Appointment> requestAppointment({
    required String patientId,
    required String doctorId,
    required DateTime scheduledAt,
    required int durationMinutes,
    required String reason,
  });

  /// Doctor confirms a requested appointment.
  ///
  /// Allowed only if current status == requested
  /// Changes status to confirmed.
  Future<void> confirmAppointment({
    required String appointmentId,
    required String doctorId,
  });

  /// Cancel an appointment.
  ///
  /// Business rules:
  /// - Patient can cancel only if:
  ///     status == confirmed
  ///     AND at least 3 hours before scheduledAt
  /// - Doctor can cancel anytime before completion
  ///
  /// Status becomes cancelled.
  Future<void> cancelAppointment({
    required String appointmentId,
    required String cancelledByUserId,
    required String cancellationReason,
  });

  /// Doctor marks an appointment as completed.
  ///
  /// Allowed only if:
  /// - status == confirmed
  /// - Caller is the assigned doctor
  ///
  /// Status becomes completed.
  Future<void> markAsCompleted({
    required String appointmentId,
    required String doctorId,
  });

  /// Patient reschedules an appointment.
  ///
  /// Allowed only if:
  /// - status == confirmed
  /// - at least 3 hours before original scheduled time
  ///
  /// Status becomes rescheduled (then back to confirmed).
  Future<void> rescheduleAppointment({
    required String appointmentId,
    required DateTime newScheduledAt,
  });

  /// Returns a stream of appointments for a specific patient.
  ///
  /// Includes all statuses.
  Stream<List<Appointment>> getPatientAppointments({
    required String patientId,
  });

  /// Returns a stream of appointments for a specific doctor.
  ///
  /// Includes all statuses.
  Stream<List<Appointment>> getDoctorAppointments({
    required String doctorId,
  });

  /// Fetch a single appointment by ID.
  Future<Appointment?> getAppointmentById({
    required String appointmentId,
  });
}