import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> makePayment(BuildContext context, String paymentKey) async {
  try {
    // 1. تهيأة الـ Payment Sheet باستخدام المفتاح القادم من الـ Backend
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentKey,
        merchantDisplayName: 'Rafiq Healthcare', // اسم براند التطبيق عندك
        style: ThemeMode.light, // أو حسب ثيم الأبليكشن
      ),
    );

    // 2. عرض صفحة الدفع للمستخدم فوراً
    await displayPaymentSheet(context);

  } catch (e) {
    debugPrint("حدث خطأ أثناء تهيأة الدفع: $e");
  }
}

Future<void> displayPaymentSheet(BuildContext context) async {
  try {
    // إظهار واجهة Stripe للمستخدم والانتظار حتى يدفع أو يكنسل
    await Stripe.instance.presentPaymentSheet();
    
    // 🔥 إذا وصل الكود هنا، معناه إن الدفع تم بنجاح مية في المية! 🎉
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم الدفع بنجاح! جاري تأكيد الحجز...')),
    );

    // الخطوة الأخيرة: الانتقال لشاشة نجاح العملية (Success Screen)
    // Navigator.pushNamed(context, '/payment-success');

  } on StripeException catch (e) {
    // التعامل مع الأخطاء الخاصة بـ Stripe (مثلاً المستخدم قفل الصفحة أو الكارت اترفض)
    if (e.error.code == FailureCode.Canceled) {
      debugPrint("المستخدم قام بإلغاء عملية الدفع.");
    } else {
      debugPrint("خطأ من Stripe: ${e.error.localizedMessage}");
    }
  } catch (e) {
    debugPrint("خطأ غير متوقع: $e");
  }
}