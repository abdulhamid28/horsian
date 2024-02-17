import 'package:horsian/Resources/exports.dart';

class BrandScreenFunctionality {
  static List<ShoeCategory> listOfCategory = [
    ShoeCategory(title: 'RUNNING ', imagePath: 'asset/images/nike shoe 1.png' , categoryType: 'FootWear_Running'),
    ShoeCategory(title: 'SNEAKERS ', imagePath: 'asset/images/a.png', categoryType: 'FootWear_Sneaker'),
    ShoeCategory(title: 'WALKING ', imagePath: 'asset/images/nike shoe 1.png', categoryType: 'FootWear_Walking'),
  ];
  // static Future<List<productContainerData>> fetchProductData({required String brandName , required String categoryType }) async {
  //   List<productContainerData> productList = [];
  //   if(categoryType==''){
  //     for(int i=0;i<listOfCategory.length;i++){
  //       QuerySnapshot<Map<String, dynamic>> innerDetail = await firebaseFirestore
  //           .collection('ShoesCollection')        // .collection('ShoesCollection')
  //           .doc(brandName)                      //.doc(brandName)
  //           .collection(listOfCategory[i].categoryType)             //.collection(categoryType)
  //           .get();
  //       for (int j = 0; j < innerDetail.docs.length; j++) {
  //         QuerySnapshot<Map<String, dynamic>> inner = await firebaseFirestore
  //             .collection('ShoesCollection')
  //             .doc(brandName)
  //             .collection(listOfCategory[i].categoryType)  // .collection(categoryType) FootWear_Sneaker
  //             .doc(innerDetail.docs[j]['Product_Name'])
  //             .collection('Available_Color')
  //             .get();
  //         productList.add(
  //           productContainerData(
  //             productPrice: inner.docs.first.data()['Product_Price'],
  //             imageBanner: inner.docs.first.data()['Product_Angle'][0],
  //             productRating: innerDetail.docs[j]['Product_Rating'],
  //             productName: innerDetail.docs[j]['Product_Name'],
  //             colorCount: inner.docs.length,
  //           ),
  //         );
  //       }
  //     }
  //   }else{
  //     QuerySnapshot<Map<String, dynamic>> innerDetail = await firebaseFirestore
  //         .collection('ShoesCollection')        // .collection('ShoesCollection')
  //         .doc(brandName)                      //.doc(brandName)
  //         .collection(categoryType)             //.collection(categoryType)
  //         .get();
  //
  //     for (int i = 0; i < innerDetail.docs.length; i++) {
  //       QuerySnapshot<Map<String, dynamic>> inner = await firebaseFirestore
  //           .collection('ShoesCollection')
  //           .doc(brandName)
  //           .collection(categoryType)  // .collection(categoryType) FootWear_Sneaker
  //           .doc(innerDetail.docs[i]['Product_Name'])
  //           .collection('Available_Color')
  //           .get();
  //       productList.add(
  //         productContainerData(
  //           productPrice: inner.docs.first.data()['Product_Price'],
  //           imageBanner: inner.docs.first.data()['Product_Angle'][0],
  //           productRating: innerDetail.docs[i]['Product_Rating'],
  //           productName: innerDetail.docs[i]['Product_Name'],
  //           colorCount: inner.docs.length,
  //         ),
  //       );
  //     }
  //   }
  //   return productList;
  //  // print(innerDetail.docs.last.data());
  // }

  static Future<List<productContainerData>> fetchAllProductData({required String brandName}) async {
   List<productContainerData> productList = [];
   for(int i=0;i<listOfCategory.length;i++) {
     QuerySnapshot<Map<String, dynamic>> categoryCollection = await firebaseFirestore
         .collection('ShoesCollection')
         .doc(brandName)
         .collection(listOfCategory[i].categoryType)
         .get();
     String brand = (listOfCategory[i].categoryType);
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
        productContainerData(
          productPrice: inner.docs.first.data()['Product_Price'],
          imageBanner: inner.docs.first.data()['Product_Angle'][0],
          productRating: value['Product_Rating'],
          productName: value['Product_Name'],
          colorCount: inner.docs.length,
          categoryType: brand
          )
      );
      // print(productList.last.categoryType);

     }
   }
   return productList;
  }

  static List<productContainerData> searchByName({required String pattern,required List<productContainerData> list}){
    List<productContainerData>productList=[];
    for(int i=0;i<list.length;i++){
      if(list[i].productName.toLowerCase().startsWith(pattern.toLowerCase())) productList.add(list[i]);
    }
   return productList;
  }

  static List<productContainerData> searchByCategory({required String category,required List<productContainerData> list}){
    List<productContainerData>productList=[];
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

class productContainerData {
  String productName;
  String imageBanner;
  int productPrice;
  double productRating;
  int colorCount;
  String categoryType;

  productContainerData(
      {required this.colorCount,
      required this.productRating,
      required this.productPrice,
      required this.productName,
      required this.categoryType,
      required this.imageBanner});
}
