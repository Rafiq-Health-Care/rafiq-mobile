import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String paymentKey;

  const PaymentEntity({required this.paymentKey});

  @override
  List<Object?> get props => [paymentKey];
}
