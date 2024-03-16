import 'dart:async';

import 'package:horsian/Resources/constants.dart';
import 'package:horsian/Resources/exports.dart';


class BaseScreenFunctionality{

 static Stream<DocumentSnapshot<Map<String, dynamic>>>  getStreamOfCartScreenCount(){
    return firebaseFirestore
        .collection(USER_COLLECTION)
        .doc(firebaseAuth.currentUser!.email)
        .snapshots();
  }

}