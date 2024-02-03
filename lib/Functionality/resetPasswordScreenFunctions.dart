import 'package:horsian/Resources/exports.dart';

class ResetPasswordScreenFuntionality{


  static Future<bool> requestResetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Toast.show('Reset link sent to ${email }' ,backgroundColor: KColor9 , duration: 2);
      return true;

    } on FirebaseException catch(error){
      Toast.show('Reset request failed !' ,backgroundColor: KColor9 , duration: 2);
      return false;
    }
  }
  
  static  changePassword({required String emailId , required String oldPassword, required String newPassword}) async {
    try{
      AuthCredential authCredential = EmailAuthProvider.credential(email: emailId, password: oldPassword);
      await firebaseAuth.currentUser!.reauthenticateWithCredential(authCredential).then((value) async =>
         await  firebaseAuth.currentUser!.updatePassword(newPassword).then((value) => updateNewPasswordToDataBase(newPassword))
      );
      Toast.show('Password updated !' ,backgroundColor: KColor9 , duration: 2);

    }on FirebaseException catch(error){
      Toast.show('Update request failed !' ,backgroundColor: KColor9 , duration: 2);

    }
  }

  static updateNewPasswordToDataBase(String newPassword) async {
    DocumentReference  ReferenceToDocumentId =
    firebaseFirestore.collection('UsersCollection').doc(firebaseAuth.currentUser!.email) ;
    ReferenceToDocumentId.update({
      "User_Password" : newPassword
    });
  }


}