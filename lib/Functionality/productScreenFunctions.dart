import 'package:horsian/Resources/exports.dart';

class ProductScreenFunctionality{
  static List<AvailableService> availableServiceList =[
    AvailableService(imagePath: 'asset/images/exchange.png', title: 'Replacement Available'),
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

}
class AvailableService{
  String title;
  String imagePath ;
  AvailableService({required this.imagePath , required this.title});
}