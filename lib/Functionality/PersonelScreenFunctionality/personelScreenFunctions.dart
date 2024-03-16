import 'package:horsian/Resources/constants.dart';
import 'package:horsian/Resources/exports.dart';

class PersonelInformationScreenFunctionality{

  static Future<DocumentSnapshot<Map<String, dynamic>>>  get()  async {
    return  firebaseFirestore.collection(USER_COLLECTION).doc(firebaseAuth.currentUser!.email).get();
  }

  static updatePersonelDetails({required String name , required String contactNumber , required String sex}){
    try {
      DocumentReference ReferenceToDocumentId = firebaseFirestore.collection(
          USER_COLLECTION).doc(firebaseAuth.currentUser!.email);
      ReferenceToDocumentId.update({
        "User_Name": name,
        "User_Gender": sex,
        "Phone_Number": contactNumber
      });
      Toast.show('Personel Data Updated!', backgroundColor: KColor9, duration: 2);
    } on FirebaseException{
      Toast.show('Unable to update !', backgroundColor: KColor9, duration: 2);

    }
  }
}