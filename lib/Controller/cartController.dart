import 'package:horsian/Resources/exports.dart';

enum CurrentShow{
  cartScreen , proceedScreen
}
class CartController extends ChangeNotifier{
    CurrentShow currentShow = CurrentShow.proceedScreen;

    CurrentShow getShow() => currentShow ;

    setShow({required CurrentShow currentShow}){
      this.currentShow = currentShow;
      notifyListeners();
    }
}
