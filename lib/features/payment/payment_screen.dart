import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/features/Consultation/presentation/dialog/consultation_booked_dialog.dart';
import 'package:rafiq/features/payment/card_information_field.dart';
import 'package:rafiq/features/payment/country.dart';
import 'package:rafiq/features/payment/country_dropdown_field.dart';
import 'package:rafiq/features/payment/pay_button.dart';
import 'package:rafiq/features/payment/payment_cubit.dart';
import 'package:rafiq/features/payment/payment_info_section.dart';
import 'package:rafiq/features/payment/payment_state.dart';
import 'package:rafiq/features/payment/price_item.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentClientSecret;
  final ConsultationSummary summary;

  const PaymentScreen({
    super.key,
    required this.paymentClientSecret,
    required this.summary,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardholderController = TextEditingController();

  final ValueNotifier<Country> _selectedCountry = ValueNotifier(
    CountryData.defaultCountry,
  ); // Egypt by default
  final ValueNotifier<bool> _cardDetails = ValueNotifier(false);

  late final Listenable _formListenable = Listenable.merge([
    _emailController,
    _cardholderController,
    _cardDetails,
  ]);

  bool get _isFormValid {
    final email = _emailController.text.trim();
    final cardholder = _cardholderController.text.trim();
    final cardComplete = _cardDetails.value;
    return email.isNotEmpty && cardholder.isNotEmpty && cardComplete;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cardholderController.dispose();
    _selectedCountry.dispose();
    _cardDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: Scaffold(
        backgroundColor: context.appTheme.surfaceColor,
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ConsultationBookedDialog(
                  onGoToAppointments: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.settings.name == RouterStrings.home,
                    );
                    context.navigateTo(RouterStrings.patientConsultations);
                  },
                ),
              );
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            final isProcessing = state is PaymentProcessing;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight),
                  const CustomScreenHeader(
                    title: 'Consultation Summary',
                    description:
                        'Review your medical appointment details before '
                        'proceeding to the secure payment gateway.',
                  ),
                  SizedBox(height: 28.h),
                  PaymentInfoSection(
                    items: widget.summary.breakdown,
                    totalLabel: widget.summary.finalTotalLabel,
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Pay with card',
                    style: TextStyle(
                      color: context.appTheme.deepDarkBlueColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  CustomLabeledTextField(
                    label: 'Email address',
                    hint: 'fatmaseleman@example.com',
                    validator: Validation.validateEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelTextStyle: TextStyle(
                      color: context.appTheme.greyColor7,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CardInformationField(
                    onCardChanged: (card) => _cardDetails.value = card,
                  ),
                  SizedBox(height: 20.h),
                  CustomLabeledTextField(
                    label: 'Cardholder Name',
                    hint: 'Full name on card',
                    validator: (v) =>
                        Validation.validateNonEmpty(v, 'Cardholder Name'),
                    controller: _cardholderController,
                    labelTextStyle: TextStyle(
                      color: context.appTheme.greyColor7,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CountryDropdownField(
                    label: 'Country or Region',
                    selectedCountry: _selectedCountry,
                  ),
                  SizedBox(height: 32.h),
                  AnimatedBuilder(
                    animation: _formListenable,
                    builder: (context, _) {
                      return PayButton(
                        label: 'Pay ${widget.summary.finalTotalLabel}',
                        isLoading: isProcessing,
                        onPressed: _isFormValid
                            ? () {
                                context.read<PaymentCubit>().confirmPayment(
                                  widget.paymentClientSecret,
                                );
                              }
                            : null,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
