import 'package:horsian/Resources/exports.dart';

class ProductScreenFunctionality{
  static List<AvailableService> availableServiceList =[
    AvailableService(imagePath: 'asset/images/exchange.png', title: 'Replace Available'),
    AvailableService(imagePath: 'asset/images/delivery.png', title: 'Free Delivery'),
    AvailableService(imagePath: 'asset/images/cash-on-delivery.png', title: 'Cash on Delivery')

  ];

   static Stream<QuerySnapshot<Map<String, dynamic>>> getProducts({required brandName , required categoryType,required productName})  {
     return  firebaseFirestore
            .collection('ShoesCollection')
            .doc(brandName)
            .collection(categoryType)
            .doc(productName)
            .collection('Available_Color').snapshots();
    }
   static bool  stockCheck({required List<dynamic> productSizeList}) {
     bool isStockAvailable = false;
     for (int val in productSizeList) if (val> 0) isStockAvailable = true;
     return isStockAvailable;
   }
   static Future<void>  addToCart({
     required ProductScreenRequired productScreenRequired , required int productQuantity,
     required String imageBanner, required  int productPrice,
     required productColor, required productSize}) async {
       DocumentReference documentReference = firebaseFirestore.collection('UsersCollection').doc(firebaseAuth.currentUser!.email);
       await documentReference.update({
         'User_Cart': FieldValue.arrayUnion([
           {
             'Product_Size': productSize ,
             'Product_Color': productColor,
             'Product_Quantity': productQuantity,
             'Product_Brand': productScreenRequired.brandName,
             'Product_Category': productScreenRequired.categoryType,
             'Product_Name': productScreenRequired.productName,
             'Product_ID': uuid.v1(),
             'Product_Banner' : imageBanner,
             'Product_Price': productPrice
           }
         ]
         )
       });
   }

}
class AvailableService{
  String title;
  String imagePath ;
  AvailableService({required this.imagePath , required this.title});
}


class ProductScreenRequired{
  String brandName;
  String categoryType ;
  String productName ;
  ProductScreenRequired({required this.productName, required this.categoryType , required this.brandName});
}

