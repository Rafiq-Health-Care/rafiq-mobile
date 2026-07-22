import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';

/// Abstraction over the payment provider (Stripe today). The presentation
/// layer only ever depends on this contract, never on the SDK directly.
abstract class PaymentRepository {
  /// Confirms the payment intent using the card details already entered
  /// on-screen. Returns [Right] on success, or [Left] with a [Failure]
  /// describing why the payment did not go through.
  Future<Either<Failure, void>> confirmPayment(
    String paymentIntentClientSecret,
  );
}
