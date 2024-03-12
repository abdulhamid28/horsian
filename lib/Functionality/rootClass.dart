import 'package:horsian/Resources/exports.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance ; //
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance ;//
UserCredential? userCredential ;//
User? currentUser ;//
UserLoginMethod? userLoginMethod ;
GoogleSignInAccount? googleSignInAccount ;
Uuid uuid = Uuid();
FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyCTGlZZR7puENLP4C2YEzMM4C7zkAWmCpw",
    appId: "1:852491001344:android:85ecae8e56bd5a2e6342e5",
    messagingSenderId: "852491001344",
    projectId: "horsian-de3cc");

