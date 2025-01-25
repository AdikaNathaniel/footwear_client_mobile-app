import 'package:dio/dio.dart';
import 'package:client_app/constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  void initializeStripe() {
  Stripe.publishableKey = "pk_test_51Ql8Us4GUh5P0VNWFj1S5Fk5aP2hN9YE0pXPqvdV7IvmkLQurgeYB7lfO2m31qLnVjy7HFSz21HsuRK5ecrSSgu700Bt9em69W";
}

  static final StripeService instance = StripeService._();

Future<void> makePayment() async {
    try {
      // Ensure Stripe is initialized
      await Stripe.instance.isPlatformPaySupported();

      String? paymentIntentClientSecret = await createPaymentIntent(100, 'usd');
      
      if (paymentIntentClientSecret == null) {
        throw Exception('Payment intent creation failed');
      }
      
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Flutter Stripe Store',
        ),
      );
      
      await _processPayment();
    } on StripeException catch (e) {
      print('Stripe Configuration Error: ${e.error.message}');
      rethrow;
    } catch (e) {
      print('Payment Error: $e');
      rethrow;
    }
  }
  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
          'payment_method_types[]': 'card'
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey"
          }
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return response.data['client_secret'] ?? "";
      }
      
      return null;
    } catch (err) {
      print('Failed to create payment intent: $err');
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print('Failed to process payment: $e');
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}