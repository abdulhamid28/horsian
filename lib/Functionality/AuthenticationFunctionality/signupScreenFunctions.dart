import 'package:horsian/Resources/constants.dart';
import 'package:horsian/Resources/exports.dart';


enum UserLoginMethod{
  nativeProvider , additionalProvider
}

class SignupScreenFunctionality{
  static Future<UserCredential?> CreateUser({ required String email , required String password}) async {
    try{
      // TODO :creating account using emailID and password
      userCredential =  await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      currentUser = userCredential!.user;
      return userCredential;
    } on FirebaseAuthException catch(error){
      Toast.show('${error.message}', backgroundColor: KColor9 ,duration: 2);
      return null;
    }
  }

  static Future<bool> StoreUserDataToFirebase({ required UserCredential userCredential, required String  fullname , required String password}) async {
    try{
      // TODO : storing user data to firebase database
      DocumentReference  ReferenceToDocumentId =
      firebaseFirestore.collection(USER_COLLECTION).doc(userCredential.user!.email) ;

      await ReferenceToDocumentId.set(
      {

        'User_ID' : userCredential.user!.uid,
        'User_Name' : fullname ,
        'User_Email' : userCredential.user!.email,
        'User_Password' : password,
        'List_Address' : [],
        'User_Points' : 0,
        'Order_Count' : 0 ,
        'Phone_Number': 0,
        'User_Gender' : 'Not Mentioned',
        'User_Cart': [],
        'Order_Current':[],
        'Order_History' : []
      }
    );
      Toast.show('Signup successful !', backgroundColor: KColor9 ,duration: 2);
    return true ;
    } on FirebaseException {
      return false;
    }
  }

  static bool isDataSufficient({required String name , required String email , required String password , required String repassword}){
    if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && repassword.isNotEmpty ){
      if(password!= repassword){
        Toast.show('Password Mismatch !' ,backgroundColor: KColor9 , duration: 2);
        return false;
      }
      if(password.length<6){
        Toast.show('Password too short !' ,backgroundColor: KColor9 , duration: 2);
        return false;
      }
    }else{
      Toast.show('Insufficient data !' ,backgroundColor: KColor9,duration: 2 , );
      return false ;
    }
    return true ;
  }

  static Future<bool> customConnectivityCheck() async {
    // TODO : checking for internetConnnectivity access
    return await InternetConnection().hasInternetAccess;
  }

  static Future<UserCredential?> SignInUsingGoogleAccount() async {
    try{
       // TODO : enable google signin configration
      googleSignInAccount =  await GoogleSignIn().signIn();
       // TODO : Engaging authentication using the selected account and creating credentials
        if(googleSignInAccount==null) return null;
        GoogleSignInAuthentication googleSignInAuthentication = await  googleSignInAccount!.authentication;
       // TODO : passing the credential
        OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken ,
            idToken: googleSignInAuthentication.idToken );
        userCredential = await firebaseAuth.signInWithCredential(oAuthCredential);
        currentUser = userCredential!.user;
        //todo : ** userLoginMethod = UserLoginMethod.additionalProvider &**;
        return userCredential;
    }on FirebaseAuthException catch(error){
        Toast.show('${error.message}', backgroundColor: KColor9 ,duration: 2);
        return null;
        }
  }

  static Future<bool> signOutUser() async {
    try{
        await  firebaseAuth.signOut();
        googleSignInAccount =  await GoogleSignIn().signOut();
        return true;
    } on FirebaseException catch(error){
      Toast.show('${error.message}', backgroundColor: KColor9 ,duration: 2);
      return false;
    }
  }



}