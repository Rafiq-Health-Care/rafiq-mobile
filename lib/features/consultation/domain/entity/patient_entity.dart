import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;

  const PatientEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  String get fullName => '$firstName $lastName'.trim();

  /// e.g. "wael lasheen" -> "WL", used for the avatar circle.
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return (f + l).toUpperCase();
  }

  @override
  List<Object?> get props => [id, firstName, lastName];
}
