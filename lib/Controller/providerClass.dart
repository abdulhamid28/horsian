import 'package:horsian/Resources/exports.dart';

class CustomProviderClass extends ChangeNotifier{
  int currentScreen=0;
  int getScreen()=> currentScreen;
  changeScreen(int screenNumber){
    currentScreen = screenNumber;
    notifyListeners();
  }

  // int productCount =0;
  // int getProductCount()=> productCount;
  // changeProduct(int productNumber){
  //   productCount = productNumber;
  //   notifyListeners();
  // }


}