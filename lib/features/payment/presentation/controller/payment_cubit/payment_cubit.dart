import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/payment/domain/use_case/confirm_payment_use_case.dart';
import 'payment_state.dart';

/// Exposes the payment confirmation flow as a simple, testable state
/// machine: initial -> processing -> success/failure. Delegates the actual
/// work to [ConfirmPaymentUseCase], so this cubit knows nothing about
/// Stripe (or any other provider).
class PaymentCubit extends Cubit<PaymentState> {
  final ConfirmPaymentUseCase confirmPaymentUseCase;

  PaymentCubit({required this.confirmPaymentUseCase})
    : super(const PaymentInitial());

  /// Confirms the payment intent using the card data already entered into
  /// the on-screen fields.
  Future<void> confirmPayment(String paymentIntentClientSecret) async {
    emit(const PaymentProcessing());

    final result = await confirmPaymentUseCase(paymentIntentClientSecret);

    result.fold(
      (failure) => emit(PaymentFailure(failure.message)),
      (_) => emit(const PaymentSuccess()),
    );
  }

  /// Resets back to the initial state, e.g. after the user dismisses an
  /// error and wants to try again.
  void reset() => emit(const PaymentInitial());
}
