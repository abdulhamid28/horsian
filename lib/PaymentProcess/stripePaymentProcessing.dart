
import 'dart:convert';
import 'package:horsian/Resources/exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePaymentGateway{
  static String uriPost = 'https://api.stripe.com/v1/payment_intents';
  static Stripe stripe = Stripe.instance;

  static String calculateAmount(String amount) => (int.parse(amount)*100).toString();
  static createPaymentIntent({required String amount , required String currency}) async {
     try{
       Map<String,dynamic> body = {
         'amount': calculateAmount(amount),
         'currency':  currency,
         'payment_method_types[]':'card',
         'description': 'Horsian purchase entry '
       };
       var response =  await http.post(
         Uri.parse(uriPost),
           headers: {
             'Authorization':'Bearer ${dotenv.env['STRIPE_PRIVATE_KEY']}',
             'Content-Type': 'application/x-www-form-urlencoded'
           },
         body: body
       );
       return jsonDecode(response.body);

     }catch(err){
        Toast.show(err.toString(),backgroundColor: KColor9, duration: 2);
        print(err.toString());
     }
  }

  static makePayment({
    required String amount,
    required String currency,
    required CartController cartController,
    required BuildContext context,
    required var snapshot
  }) async {
    try{
      var paymentIntent = await createPaymentIntent(amount: amount, currency: currency);
      print(paymentIntent.toString());
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Horsian',
          )
      ).then((value) async {
        await Stripe.instance.presentPaymentSheet(options: PaymentSheetPresentOptions(timeout: 30)).then((value) {
          showDialog(useSafeArea: true,
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Container(
                    height: 300,width: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconlyLight.tick_square,size: 90,color: Colors.green,),
                        Text('Order Placed',textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontFamily: 'Axiforma',
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
              Future.delayed(Duration(seconds: 2),
              () async {
                await CartScreenFunctionality.updateOrder();
                cartController.setShow(currentShow: CurrentShow.proceedScreen);
                Navigator.of(context).pop();
                await CartScreenFunctionality.updateProductDatabase(userCart:snapshot );
                CartScreenFunctionality.emptyUserCart();
              }
          );
        }
        );
      });
      paymentIntent = null;
    } on StripeException catch(err){
      showDialog(useSafeArea: true,
          context: context,
          builder: (context){
            return AlertDialog(
              content: Container(
                height: 300,width: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.close_square,size: 90,color: Colors.red[800],),
                    Text('Payment failed',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 25,
                          fontFamily: 'Axiforma',
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }
}