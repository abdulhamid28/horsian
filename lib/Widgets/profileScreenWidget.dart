
import 'package:horsian/Resources/exports.dart';

class InformationCard{
  IconData iconData;
  String h1Tag ;
  String h2Tag;
  Widget navigateTo ;
  InformationCard({ required this.iconData , required this.h1Tag , required this.h2Tag , required this.navigateTo });
}

List<InformationCard> ProfileWidgetList =[
  InformationCard(
      iconData: IconlyBold.location,
      h1Tag: 'Address',
      h2Tag: 'Manage delivery address',
      navigateTo:  AddressScreen()
  ),
  InformationCard(
      iconData: IconlyBold.editSquare,
      h1Tag: 'Personel Information',
      h2Tag: 'Detailed information of user',
      navigateTo:  PersonelInformationScreen()
  ),
  InformationCard(
      iconData: IconlyBold.buy,
      h1Tag: 'Orders',
      h2Tag: 'Shoes purchased',
      navigateTo:  OrdersScreen()
  ),
  InformationCard(
      iconData: IconlyBold.shield_done,
      h1Tag: 'Login & Security',
      h2Tag: 'Manage user credential ',
      navigateTo: ChangePasswordScreen()

  ),
  InformationCard(
      iconData: IconlyBold.logout,
      h1Tag: 'Logout',
      h2Tag: 'Signout from this device',
      navigateTo:  AddressScreen()
  ),
];