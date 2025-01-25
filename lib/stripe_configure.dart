import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../services/stripe_service.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  _StripePaymentScreenState createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stripe Payment'),
        ),
      body: SizedBox.expand(
        child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment:   CrossAxisAlignment.center,
             children: [
                MaterialButton(
                  onPressed: (){
                    StripeService.instance.makePayment();
                  },
                  color:Colors.green,
                  child: const Text('Make Payment'),
                ),
             ],
        ),
      ) 
    );
  }

 
}
