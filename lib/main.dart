import 'package:horsian/Resources/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCTGlZZR7puENLP4C2YEzMM4C7zkAWmCpw",
        appId: "1:852491001344:android:85ecae8e56bd5a2e6342e5",
        messagingSenderId: "852491001344",
        projectId: "horsian-de3cc")) : await Firebase.initializeApp()  ;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white,));
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
       //SplashScreen(),
       BaseScreen(),
       // SignupScreen() ,
       // LoginScreen(),
       //OnboardingScreen(),
    );
  }
}
