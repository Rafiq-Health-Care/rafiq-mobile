/// States emitted by [PaymentCubit] while confirming a Stripe payment.
sealed class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentProcessing extends PaymentState {
  const PaymentProcessing();
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

class PaymentFailure extends PaymentState {
  final String message;
  const PaymentFailure(this.message);
}
