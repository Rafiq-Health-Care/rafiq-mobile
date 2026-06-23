import 'package:rafiq/features/Consultation/domain/entity/payment_entity.dart';

class PaymentModel {
  final String paymentKey;

  const PaymentModel({required this.paymentKey});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentKey: json['paymentKey'] ?? '',
    );
  }

  PaymentEntity toEntity() {
    return PaymentEntity(paymentKey: paymentKey);
  }
}