import 'package:objectbox/objectbox.dart';

@Entity()
class MedicineEntity {
  @Id()
  int objectBoxID;

  final String apiId;
  final String userEmail;
  final String status;
  final String encryptedData;

  MedicineEntity({
    this.objectBoxID = 0,
    required this.apiId,
    required this.userEmail,
    required this.status,
    required this.encryptedData,
  });
}
