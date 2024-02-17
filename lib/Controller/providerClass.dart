import 'package:horsian/Resources/exports.dart';

class CustomProviderClass extends ChangeNotifier{
  //TODO: ChangeScreen Controller for base Screen
  int currentScreen=0;
  int getScreen()=> currentScreen;
  changeScreen(int screenNumber){
    currentScreen = screenNumber;
    notifyListeners();
  }

  List<productContainerData> allProducts=[];
  List getAllProduct()=>allProducts;
  setProduct(List<productContainerData> products) {
    allProducts = products;
  }
}


