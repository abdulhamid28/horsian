import 'package:horsian/Resources/exports.dart';
enum IncreaseDecrease{
  Increase , decrease
}
class CartScreenFunctionality{
  static List<CustomStep> listOfSteps = [
    CustomStep(title: 'Products', icon: IconlyBold.bag_2),
    CustomStep(title: 'Address', icon: IconlyBold.location),
    CustomStep(title: 'Checkout', icon: IconlyBold.wallet),
  ];


  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCart()=>
      firebaseFirestore.collection('UsersCollection').doc(firebaseAuth.currentUser!.email).snapshots();


  void deleteCart({required String productId}) async {
    try{
      final collectionPath = firebaseFirestore
          .collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email);
      final collection = await collectionPath.get();
      List listOfCart = collection['User_Cart'];
      List needToDelete = listOfCart
          .where((element) => element['Product_ID'].contains(productId))
          .toList();
      await collectionPath.update(
        {
          'User_Cart': FieldValue.arrayRemove(needToDelete),
        },
      );
    }on FirebaseException catch(error){
      Toast.show(error.message.toString(), duration: 2, backgroundColor: KColor9);
    }

  }

  Future<void> increaseQuantityCart({required IncreaseDecrease val , required productId}) async {
    try {
      final collectionPath = firebaseFirestore.collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email);
      final collection = await collectionPath.get();
      List listOfCart = collection['User_Cart'];
      List needToDelete = listOfCart
          .where((element) => element['Product_ID'].contains(productId))
          .toList();

      if (needToDelete.length != 0) {
        if (val == IncreaseDecrease.Increase &&
            needToDelete[0]['Product_Quantity'] < 10) {
          collectionPath.update(
            {
              'User_Cart': FieldValue.arrayRemove(needToDelete),
            },
          );
          ++needToDelete[0]['Product_Quantity'];
        }
        if (val == IncreaseDecrease.decrease &&
            needToDelete[0]['Product_Quantity'] > 1) {
          collectionPath.update(
            {
              'User_Cart': FieldValue.arrayRemove(needToDelete),
            },
          );
          --needToDelete[0]['Product_Quantity'];
        }
        await collectionPath.update({
          'User_Cart': FieldValue.arrayUnion(needToDelete)
        });
      }
    } on FirebaseException catch(error){
      Toast.show(error.message.toString(),backgroundColor: KColor9,duration: 2);
    }

  }

  static Future<void> emptyUserCart() async {
    try{
        final collectionPath = firebaseFirestore
            .collection('UsersCollection')
            .doc(firebaseAuth.currentUser!.email);
        await collectionPath.update(
          {
            'User_Cart': []
          },
        );
    }on FirebaseException catch(error){
      Toast.show(error.message.toString(),backgroundColor: KColor9,duration: 2);
    }
  }

  static updateOrder() async {
    try{
      final collectionPath = firebaseFirestore
          .collection('UsersCollection')
          .doc(firebaseAuth.currentUser!.email);
      final collection = await collectionPath.get();
      var listOfCart = collection['User_Cart'];
      for(int i=0;i<listOfCart.length;i++){
        var val = listOfCart[i];
        val['Order_Status']= 'Dispatched';
        listOfCart[i]=val;
      }
      // int val = collection['Order_Count'];
     await  collectionPath.update(
        {
          'Order_Current': FieldValue.arrayUnion(listOfCart),
          'Order_Count' : FieldValue.increment(1),
          'User_Points':  FieldValue.increment(20)
        },
      );

    }on FirebaseException catch(error){
      Toast.show(error.message.toString(),backgroundColor: KColor9,duration: 2);
    }
  }

  static double calculateTotalAmount({required List product}){
    double  totalsum =0.0;
    for(int i=0;i<product.length;i++){
    num val1 =  product[i]['Product_Quantity'];
    num val2 =  product[i]['Product_Price'] ;
    totalsum = totalsum +(val1*val2);
    }
    return totalsum;
  }
  static String findColorName({required String productColor}){
    if(!productColor.contains(' ')) return productColor;
    else {
      List<String> temp = productColor.split(' ');
      return temp[0].trim()+"_"+temp[1].trim();
    }
  }
  static updateProductDatabase({required var userCart}) async {
    try{
      for(int i=0;i<userCart.length;i++){
        String color = findColorName(productColor: userCart[i]['Product_Color']);
        final collectionPath =  firebaseFirestore
            .collection('ShoesCollection')
            .doc(userCart[i]['Product_Brand'])
            .collection(userCart[i]['Product_Category'])
            .doc(userCart[i]['Product_Name'])
            .collection('Available_Color').doc(color);
        final collection = await collectionPath.get();
        List productSizeList = collection['Product_Size'];
        productSizeList[userCart[i]['Product_Size']-6] =
            productSizeList[userCart[i]['Product_Size']-6]-userCart[i]['Product_Quantity'];
        await collectionPath.update(
            {
              'Product_Size' : productSizeList
            }
        );
      }
    }on FirebaseException catch(error){
      Toast.show(error.message.toString(),duration: 2,backgroundColor: KColor9);
    }
  }


}

class CustomStep{
  IconData icon  ;
  String title ;
  CustomStep({required this.title, required this.icon});
}


