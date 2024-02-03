import 'package:horsian/Resources/exports.dart';
class LoginScreenFunctionality{

  bool emailValidation({required String email})=>
      RegExp("^(.+)@(\\S+).com\$" ,caseSensitive: false,multiLine: false).hasMatch(email);

  static bool isDataSufficient({required String email , required String password }){
    if(email.isNotEmpty && password.isNotEmpty){
      if(password.length<6){
        Toast.show('Check your Password !' ,backgroundColor: KColor9 , duration: 2);
        return false;
      }
    }else{
      Toast.show('Insufficient data !' ,backgroundColor: KColor9,duration: 2 , );
      return false ;
    }
    return true ;
  }

  // Todo : login user  ( userSignedInMethod = 'Nativeprovider';)
  static  Future<UserCredential?> loginUserUsingUserIdAndPassword({required String email , required String password}) async {
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Toast.show('Login successful', backgroundColor: KColor9, duration: 2);
     //RedirectingFunctionality.setDataInLocalTrue();
     // RedirectingFunctionality.createLocalDataForNativeProvider(email: email, password: password);
      return userCredential;
    } on FirebaseException catch (error) {
      Toast.show('${error.message}', backgroundColor: KColor9, duration: 2);
      return null;
    }
  }

}