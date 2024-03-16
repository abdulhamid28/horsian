import 'package:horsian/Resources/constants.dart';
import 'package:horsian/Resources/exports.dart';

enum Screen{
  homeScreen,
  favouriteScreen,
  notificationScreen,
  cartScreen,
  profileScreen,
  addressScreen,
  brandScreen
}
class BottomBarWidget{
  IconData bottomBarIcon ;
  Widget screen ;
  Screen screenName ;
  String lightText ;
  String boldText ;
  BottomBarWidget({required this.bottomBarIcon , required this.screen , required this.screenName , required this.boldText , required this.lightText});
}

 List<BottomBarWidget> bottomBarWidgetList = [
  BottomBarWidget(bottomBarIcon: IconlyLight.home, screen: HomeScreen() , screenName: Screen.homeScreen, lightText: 'Explore' , boldText: 'Collections'),
   BottomBarWidget(bottomBarIcon: IconlyLight.bag_2 ,screen: CartScreen(),screenName:Screen.cartScreen , lightText: 'My' , boldText: 'Cart'),
   BottomBarWidget(bottomBarIcon: IconlyLight.notification, screen: NotificationScreen(),screenName: Screen.notificationScreen , lightText: 'Deals' , boldText: 'Recommended'),
  BottomBarWidget(bottomBarIcon: IconlyLight.profile, screen: ProfileScreen(),screenName: Screen.profileScreen,lightText: '' , boldText: ''),
  BottomBarWidget(bottomBarIcon: Icons.abc, screen: BrandScreen(brand: BRAND_ADIDAS, ), screenName: Screen.brandScreen, boldText: '', lightText: ''),
  BottomBarWidget(bottomBarIcon: Icons.abc, screen: BrandScreen(brand: BRAND_NIKE), screenName: Screen.brandScreen, boldText: '', lightText: ''),
 ];

