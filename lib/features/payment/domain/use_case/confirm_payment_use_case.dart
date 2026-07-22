import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/payment/domain/repository/payment_repository.dart';

class ConfirmPaymentUseCase {
  final PaymentRepository repository;

  const ConfirmPaymentUseCase(this.repository);

  Future<Either<Failure, void>> call(String paymentIntentClientSecret) {
    return repository.confirmPayment(paymentIntentClientSecret);
  }
}
