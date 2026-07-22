import 'package:flutter_stripe/flutter_stripe.dart';

/// Talks to the Stripe SDK directly. Kept behind an interface so the
/// repository (and everything above it) never depends on `flutter_stripe`
/// itself — swapping payment providers later only means adding a new
/// implementation of this class.
abstract class StripePaymentDataSource {
  Future<PaymentIntentsStatus> confirmPayment(
    String paymentIntentClientSecret,
  );
}

class StripePaymentDataSourceImpl implements StripePaymentDataSource {
  @override
  Future<PaymentIntentsStatus> confirmPayment(
    String paymentIntentClientSecret,
  ) async {
    final paymentIntent = await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: paymentIntentClientSecret,
      data: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );
    return paymentIntent.status;
  }
}
