import 'package:horsian/Resources/exports.dart';

class CustomProviderClass extends ChangeNotifier{
  //TODO: ChangeScreen Controller for base Screen
  int currentScreen=0;
  int getScreen()=> currentScreen;
  changeScreen(int screenNumber){
    currentScreen = screenNumber;
    notifyListeners();
  }

  List<ProductContainerData> allProducts=[];
  List getAllProduct()=>allProducts;
  setProduct(List<ProductContainerData> products) {
    allProducts = products;
  }

}


