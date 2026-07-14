import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'payment_state.dart';

/// Handles the Stripe payment confirmation flow and exposes it as a
/// simple, testable state machine: initial -> processing -> success/failure.
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitial());

  /// Confirms the payment intent using the card data already entered into
  /// the on-screen [CardField]. Mirrors the original confirmPayment logic,
  /// but reports progress through emitted states instead of dialogs, so the
  /// UI layer stays fully decoupled from the payment logic.
  Future<void> confirmPayment(String paymentIntentClientSecret) async {
    emit(const PaymentProcessing());
    try {
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: paymentIntentClientSecret,
        data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        emit(const PaymentSuccess());
      } else {
        emit(
          PaymentFailure(
            'Payment was not completed. Status: ${paymentIntent.status}',
          ),
        );
      }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  /// Resets back to the initial state, e.g. after the user dismisses an
  /// error and wants to try again.
  void reset() => emit(const PaymentInitial());
}
