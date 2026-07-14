import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';

/// Card information section built from 3 separate custom fields:
/// card number (full width), then expiry date and CVV side by side.
///
/// Stripe's built-in CardField/CardFormField can't be split into
/// independently-styled boxes like this, so this widget collects the
/// raw values itself and feeds them to Stripe via
/// [Stripe.instance.dangerouslyUpdateCardDetails]. When the fields are
/// complete, [onCardChanged] reports `true` and the SDK already has the
/// card data ready for createPaymentMethod / confirmPayment.
class CardInformationField extends StatefulWidget {
  final ValueChanged<bool> onCardChanged;

  const CardInformationField({super.key, required this.onCardChanged});

  @override
  State<CardInformationField> createState() => _CardInformationFieldState();
}

class _CardInformationFieldState extends State<CardInformationField> {
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _handleChange() {
    final number = _numberController.text.replaceAll(' ', '');
    final expiryDigits = _expiryController.text.replaceAll('/', '');
    final cvc = _cvcController.text;

    int? month;
    int? year;
    if (expiryDigits.length == 4) {
      month = int.tryParse(expiryDigits.substring(0, 2));
      year = int.tryParse('20${expiryDigits.substring(2, 4)}');
    }

    final isComplete =
        number.length >= 13 &&
        month != null &&
        month >= 1 &&
        month <= 12 &&
        year != null &&
        cvc.length >= 3;

    if (isComplete) {
      Stripe.instance.dangerouslyUpdateCardDetails(
        CardDetails(
          number: number,
          expirationMonth: month,
          expirationYear: year,
          cvc: cvc,
        ),
      );
    }

    widget.onCardChanged(isComplete);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabeledTextField(
          label: 'Card number',
          controller: _numberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _CardNumberFormatter(),
          ],
          validator: (v) => Validation.validateNonEmpty(v, 'Card Number'),
          hint: '1234 2364 1234 4968',
          onChanged: (_) => _handleChange(),
          labelTextStyle: TextStyle(
            color: context.appTheme.greyColor7,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 12.h),
        // Expiry + CVV — side by side
        Row(
          children: [
            Expanded(
              child: CustomLabeledTextField(
                controller: _expiryController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _ExpiryDateFormatter(),
                ],
                validator: (v) => Validation.validateNonEmpty(v, 'Expiry Date'),
                onChanged: (_) => _handleChange(),
                hint: 'MM/YY',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomLabeledTextField(
                controller: _cvcController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (v) => Validation.validateNonEmpty(v, 'CVV'),
                onChanged: (_) => _handleChange(),
                hint: 'CVV',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Formats digits as "1234 5678 9012 3456" while typing.
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 16 ? digits.substring(0, 16) : digits;

    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      buffer.write(limited[i]);
      if ((i + 1) % 4 == 0 && i + 1 != limited.length) buffer.write(' ');
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formats digits as "MM/YY" while typing.
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 4 ? digits.substring(0, 4) : digits;

    final formatted = limited.length <= 2
        ? limited
        : '${limited.substring(0, 2)}/${limited.substring(2)}';

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
