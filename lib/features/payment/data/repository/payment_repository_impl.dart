import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/payment_failure.dart';
import 'package:rafiq/features/payment/data/data_source/stripe_payment_data_source.dart';
import 'package:rafiq/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final StripePaymentDataSource dataSource;

  const PaymentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> confirmPayment(
    String paymentIntentClientSecret,
  ) async {
    try {
      final status = await dataSource.confirmPayment(
        paymentIntentClientSecret,
      );

      if (status == PaymentIntentsStatus.Succeeded) {
        return const Right(null);
      }

      return Left(
        PaymentFailure('Payment was not completed. Status: $status'),
      );
    } catch (e) {
      return Left(PaymentFailure(e.toString()));
    }
  }
}
