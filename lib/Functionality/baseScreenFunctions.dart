import 'dart:async';

import 'package:horsian/Resources/exports.dart';


class BaseScreenFunctionality{

 static Stream<DocumentSnapshot<Map<String, dynamic>>>  getStreamOfCartScreenCount(){
    return firebaseFirestore
        .collection('UsersCollection')
        .doc(firebaseAuth.currentUser!.email)
        .snapshots();
  }

}