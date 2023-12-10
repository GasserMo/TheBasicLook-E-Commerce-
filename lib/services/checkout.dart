/* import 'package:flutter_stripe/flutter_stripe.dart';

class MobileCheckout {
  static Future<void> startCheckout(String sessionId) async {
    try {
      StripePayment.setOptions(
        StripeOptions(
          publishableKey: "your_publishable_key",
          merchantId: "your_merchant_id",
        ),
      );

      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: sessionId,
        ),
      );

      if (response.status == 'succeeded') {
        // Payment succeeded
        print('Payment succeeded');
      } else {
        // Payment failed
        print('Payment failed');
      }
    } catch (error) {
      print('Error during payment: $error');
    }
  }
}
 */