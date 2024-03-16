import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:horsian/Resources/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Stripe.publishableKey= dotenv.env['STRIPE_PUBLIC_KEY']! ;
  Stripe.instance.applySettings();
  Platform.isAndroid ? await Firebase.initializeApp(options: firebaseOptions) : await Firebase.initializeApp()  ;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white,));
  await NotificationServices.requestPermission();
  runApp(
  ChangeNotifierProvider(
      create: (context)=> CustomProviderClass(),
      child : Horsian())
  );
}

class Horsian extends StatelessWidget {
  const Horsian({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home:
       // ChangePasswordScreen(),
       //ProfileScreen()
       //AddressScreen(),
       //ResetPasswordScreen(),
       (firebaseAuth.currentUser!=null )? BaseScreen() :SplashScreen(),
       //BaseScreen(),
       // SignupScreen() ,
       // LoginScreen(),
       //OnboardingScreen(),
    );
  }
}
