class DoctorEntity {
  final String doctorId;
  final String firstName;
  final String lastName;
  final String specialization;
  final String? personalPhoto;
  final String nextAvailable;
  final double price;
  final double rating;
  final int yearsOfExperience;

  DoctorEntity({
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.personalPhoto,
    required this.nextAvailable,
    required this.price,
    required this.rating,
    required this.yearsOfExperience,
  });
}
