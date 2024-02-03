// import 'package:horsian/Resources/exports.dart';
//
// class RedirectingFunctionality{
//
//   static Future<bool?> checkDataExistInLocal() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? a = await sharedPreferences.getBool('Account logged ');
//     print('${a}*******************************checkDataExistInLocal****************************');
//     return  a ;
//   }
//
//   static Future<bool?> setDataInLocalTrue() async {
//
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//
//     bool? a = await sharedPreferences.setBool('Account logged ', true);
//     print('${a}****************************setDataInLocalTrue********************************************');
//     return  a ;
//   }
//
//   static Future<bool?> setDataInLocalFalse() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? a =  await sharedPreferences.setBool('Account logged ', false);
//     print('${a}****************************************setDataInLocalFalse***************************************************');
//     return  a ;
//   }
//
//   static Future<bool> createLocalDataForNativeProvider({required String email , required password}) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? a = await sharedPreferences.setStringList('NativeProvider', [email , password]);
//     print('${a}***************************createLocalDataForNativeProvider called*****************************');
//     return  a ;
//   }
//
//   static Future<bool> createLocalDataForAdictionalProvider({required String accessToken , required String tokenId}) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? a = await sharedPreferences.setStringList('AdictionalProvider', [accessToken , tokenId]);
//     print('${a}***********************createLocalDataForAdictionalProvider********************************');
//     return  a ;
//   }
//
//   static Future<List<String>?> retriveLocalDataForNativeProvider() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     print('***********************retrieveLocalDataForNativeProvider called************************');
//     return sharedPreferences.getStringList('NativeProvider');
//   }
//
//   static Future<List<String>?> retriveLocalDataForAdictionalProvider() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     print('***********************retrieveLocalDataForAdictionalProvider called************************');
//     return sharedPreferences.getStringList('AdictionalProvider');
//   }
//
// }