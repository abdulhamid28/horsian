import 'package:horsian/Resources/exports.dart';

class BrandScreenFunctionality {

  static List<ShoeCategory> listOfCategory = [
    ShoeCategory(title: 'RUNNING ', imagePath: 'asset/images/nike shoe 1.png' , categoryType: 'FootWear_Running'),
    ShoeCategory(title: 'SNEAKERS ', imagePath: 'asset/images/a.png', categoryType: 'FootWear_Sneaker'),
    ShoeCategory(title: 'WALKING ', imagePath: 'asset/images/nike shoe 1.png', categoryType: 'FootWear_Walking'),
  ];

  static Future<List<ProductContainerData>> fetchAllProductData({required String brandName}) async {
   List<ProductContainerData> productList = [];
   for(int i=0;i<listOfCategory.length;i++) {
     QuerySnapshot<Map<String, dynamic>> categoryCollection = await firebaseFirestore
         .collection('ShoesCollection')
         .doc(brandName)
         .collection(listOfCategory[i].categoryType)
         .get();
     for(var categoryCollectionDoc in categoryCollection.docs){
      Map<String, dynamic> value =  categoryCollectionDoc.data();
      QuerySnapshot<Map<String, dynamic>> inner = await firebaseFirestore
          .collection('ShoesCollection')
          .doc(brandName)
          .collection(listOfCategory[i].categoryType)
          .doc(value['Product_Name'])
          .collection('Available_Color')
          .get();
      productList.add(
        ProductContainerData(
          productPrice: inner.docs.first.data()['Product_Price'],
          imageBanner: inner.docs.first.data()['Product_Angle'][0],
          productRating: value['Product_Rating'],
          productName: value['Product_Name'],
          colorCount: inner.docs.length,
          categoryType: listOfCategory[i].categoryType,
          // productDescription1: value['Product_Description_H1'] ,
          // productDescription2: value['Product_Description_H2'],
          // productDescriptionImage: value['Product_Description_Image'],
          brandName: brandName
          )
      );
     }
   }
   return productList;
  }

  static List<ProductContainerData> searchByName({required String pattern,required List<ProductContainerData> list}){
    List<ProductContainerData>productList=[];
    for(int i=0;i<list.length;i++){
      if(list[i].productName.toLowerCase().startsWith(pattern.toLowerCase())) productList.add(list[i]);
    }
   return productList;
  }

  static List<ProductContainerData> searchByCategory({required String category,required List<ProductContainerData> list}){
    List<ProductContainerData>productList=[];
    for(int i=0;i<list.length;i++){
      if(list[i].categoryType.toLowerCase().startsWith(category.toLowerCase())) productList.add(list[i]);
    }
    return productList;
  }

}

class ShoeCategory {
  String title;
  String categoryType ;
  String imagePath;
  ShoeCategory({required this.title, required this.imagePath , required this.categoryType});
}

class ProductContainerData {
  String productName;   //okay
  String imageBanner;   // okay
  int productPrice;    // okay
  double productRating;  //okay
  int colorCount;     //okay
  String categoryType;   //okay
  // String productDescription1;   //no
  // String productDescription2;   //no
  // String productDescriptionImage; // no
  String brandName;
  ProductContainerData(
      {
      required this.colorCount,
      required this.productRating,
      required this.productPrice,
      required this.productName,
      required this.categoryType,
      required this.imageBanner,
      // required this.productDescription1,
      // required this.productDescription2,
      // required this.productDescriptionImage,
      required this.brandName
      });
}
