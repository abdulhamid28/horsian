import 'package:horsian/Resources/exports.dart';

class HomeScreenFunctionality {
  static List<PopularBrandContainer> popularBrandNameList=[
    PopularBrandContainer(
        brandName: 'Brand_Nike',
        brandLogo: 'asset/images/nike_logo.png',
        brandVideoLink: 'https://firebasestorage.googleapis.com/v0/b/horsian-de3cc.appspot.com/o/Brands%2FNike%2Fnike%20trim%20video.m4v?alt=media&token=3ec35a38-d443-456a-a26b-84262ac73b36'
    ),
  PopularBrandContainer(
      brandName: 'Brand_Adidas',
      brandLogo: 'asset/images/adidas_logo.png',
      brandVideoLink: 'https://firebasestorage.googleapis.com/v0/b/horsian-de3cc.appspot.com/o/Brands%2FAdidas%2Fadidas%20trim%20video.mp4?alt=media&token=8887113b-6e7a-499b-895c-18689808addb')


  ];

  static List<String> carouselImageList = [
    'asset/images/adidas.png',
    'asset/images/nike.png',
    'asset/images/puma1.jpg',
    'asset/images/reebok.png',
    'asset/images/fila.png'
  ];

  static List<Widget> generateCarouselWidget() {
    List<Widget> tempList = [];
    for (int i = 0; i < carouselImageList.length; i++)
      tempList.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            carouselImageList[i],
            fit: BoxFit.fill,
          ),
        ),
      );
    return tempList;
  }

  static Future<List<ProductContainerData>> getTrendingProducts() async {
    List<ProductContainerData> productList = [];
    for (var brandName in HomeScreenFunctionality.popularBrandNameList){
      for (int i = 0; i < BrandScreenFunctionality.listOfCategory.length; i++) {
        QuerySnapshot<
            Map<String, dynamic>> categoryCollection = await firebaseFirestore
            .collection('ShoesCollection')
            .doc(brandName.brandName)
            .collection(BrandScreenFunctionality.listOfCategory[i].categoryType).where('Product_Trending' , isEqualTo: true)
            .get();
        for (var categoryCollectionDoc in categoryCollection.docs) {
          Map<String, dynamic> value = categoryCollectionDoc.data();
          QuerySnapshot<Map<String, dynamic>> inner = await firebaseFirestore
              .collection('ShoesCollection')
              .doc(brandName.brandName)
              .collection(
              BrandScreenFunctionality.listOfCategory[i].categoryType)
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
                  categoryType: BrandScreenFunctionality.listOfCategory[i].categoryType,
                  productDescription1: value['Product_Description_H1'],
                  productDescription2: value['Product_Description_H2'],
                  productDescriptionImage: value['Product_Description_Image'],
                brandName:  brandName.brandName
              )
          );
        }
      }
    }
    return productList;
  }
}

class PopularBrandContainer{
  String brandName ;
  String brandLogo;
  String brandVideoLink;
  PopularBrandContainer({required this.brandName, required this.brandLogo , required this.brandVideoLink});
}

