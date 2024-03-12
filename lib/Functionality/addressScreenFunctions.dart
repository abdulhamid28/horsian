import 'package:horsian/Resources/exports.dart';

class AddressScreenFunctionality {

  static bool validateAddress({required String recieverName,
      required String phoneNumber,
      required String doorNo,
      required String streetName,
      required String areaName,
      required String cityName,
      required String pincode,
      required String stateName,
      required String countryName,
      required homeBool,
      required flatBool}) {
    bool isValid = (recieverName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        doorNo.isNotEmpty &&
        streetName.isNotEmpty &&
        stateName.isNotEmpty &&
        cityName.isNotEmpty &&
        countryName.isNotEmpty &&
        pincode.isNotEmpty &&
        areaName.isNotEmpty &&
        (homeBool || flatBool));
    if (!isValid)
      Toast.show('Insufficient data', backgroundColor: KColor9, duration: 2);
    return isValid;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStoredAddress() {
    return firebaseFirestore
        .collection('UsersCollection')
        .doc(firebaseAuth.currentUser!.email)
        .snapshots(); // todo :
  }

  void deleteStoredAddress({required String addressId}) async {
    try {
      final collectionPath = firebaseFirestore
          .collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email); // todo :
      final collection = await collectionPath.get();
      List listOfAddress = collection['List_Address'];
      List needToDelete = listOfAddress
          .where((element) => element['Address_Id'].contains(addressId))
          .toList();
      collectionPath.update(
        {
          'List_Address': FieldValue.arrayRemove(needToDelete),
        },
      );
      Toast.show('Deleted Successfully', backgroundColor: KColor9, duration: 2);
    } on FirebaseException catch (error) {
      Toast.show('${error.message}', backgroundColor: KColor9, duration: 2);
    }
  }

  void editStoredAddress({
    required addressId,
    required recieverName,
    required contactNumber,
    required type,
    required doorNumber,
    required landMark,
    required streetName,
    required areaName,
    required cityName,
    required pincode,
    required stateName,
    required countryName,
  }) async {
    try {
      final collectionPath = firebaseFirestore
          .collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email); // todo :
      final collection = await collectionPath.get();
      List listOfAddress = collection['List_Address'];
      List needToDelete = listOfAddress
          .where((element) => element['Address_Id'].contains(addressId))
          .toList();
      collectionPath.update(
        {
          'List_Address': FieldValue.arrayRemove(needToDelete),
        },
      );
      collectionPath.update(
        {
          'List_Address': FieldValue.arrayUnion(
            [
              {
                'Reciever_Name': recieverName,
                'Contact_Number': contactNumber,
                'Type': type,
                'Door_Number': doorNumber,
                'Landmark': landMark,
                'Street_Name': streetName,
                'Area_Name': areaName,
                'City_Name': cityName,
                'Pincode': pincode,
                'State_Name': stateName,
                'Country_Name': countryName,
                'Address_Id': uuid.v1()
              }
            ],
          ),
        },
      );
      Toast.show('Edited Successfully', backgroundColor: KColor9, duration: 2);
    } on FirebaseException catch (error) {
      Toast.show('${error.message}', backgroundColor: KColor9, duration: 2);
    }
  }

  bool addAddress({
    required recieverName,
    required contactNumber,
    required type,
    required doorNumber,
    required landMark,
    required streetName,
    required areaName,
    required cityName,
    required pincode,
    required stateName,
    required countryName,
  }) {
    try {
      final collectionPath = firebaseFirestore
          .collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email);
      collectionPath.update(
        {
          'List_Address': FieldValue.arrayUnion(
            [
              {
                'Reciever_Name': recieverName,
                'Contact_Number': contactNumber,
                'Type': type,
                'Door_Number': doorNumber,
                'Landmark': landMark,
                'Street_Name': streetName,
                'Area_Name': areaName,
                'City_Name': cityName,
                'Pincode': pincode,
                'State_Name': stateName,
                'Country_Name': countryName,
                'Address_Id': new DateTime.timestamp().toString()
              }
            ],
          ),
        },
      );
      Toast.show('Added Successfully', backgroundColor: KColor9, duration: 2);

      return true;
    } on FirebaseException catch (error) {
      Toast.show('${error.message}', backgroundColor: KColor9, duration: 2);
      return false;
    }
  }


  //todo
  static  Future<DocumentSnapshot<Map<String, dynamic>>> getSpecificAddressData(){
    return firebaseFirestore.collection('UsersCollection').doc(firebaseAuth.currentUser!.email).get();

  }
}
