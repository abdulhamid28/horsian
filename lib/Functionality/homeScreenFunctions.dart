import 'package:horsian/Resources/exports.dart';

class HomeScreenFunctionality {
  static List<String> popularBrandList = [
    'asset/images/adidas_logo.png',
 //   'asset/images/puma_logo3.png',
    'asset/images/nike_logo.png',
 //   'asset/images/reebok_logo.png'
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
}
