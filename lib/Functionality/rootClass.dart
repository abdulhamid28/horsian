import 'package:horsian/Resources/exports.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance ;
UserCredential? userCredential ;
User? currentUser ;
UserLoginMethod? userLoginMethod ;
GoogleSignInAccount? googleSignInAccount ;
