import 'package:horsian/Resources/exports.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserInformationSection(),
          ProfileCardSection(),
        ],
      ),
    );
  }

  Expanded ProfileCardSection() {
    return Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Column(
                children: ProfileScreenFunctionality.generateWidget()),
          ),
        );
  }

  Expanded UserInformationSection() {
    return Expanded(
            flex: 4,
            child: Center(
              child: StreamBuilder(
                  stream: ProfileScreenFunctionality.getProfileData(),
                  builder:(context , snap){
                    if(snap.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                border: Border.all(
                                    width: 5, color: KColor9)),
                            child: (snap.data!["User_Gender"]== 'Male') ? Image.asset('asset/images/boy.png') :  Image.asset('asset/images/girl.png')  ,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: snap.data!["User_Name"] + '\n',
                                  style: TextStyle(
                                      color: KColor9,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Axiforma'),
                                ),
                                TextSpan(
                                  text: snap.data!["User_Email"],
                                  style: TextStyle(
                                      color: KColor8,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Axiforma'),
                                )
                              ],
                            ),
                          ),
                          ProfileScreenFunctionality.walletAndOrders(
                              walletPoints: snap.data!["User_Points"].toInt(),
                              orderCount: snap.data!["Order_Count"].toInt())
                        ],
                      );
                    }else{
                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(75),
                                border: Border.all(width: 5, color: KColor9)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                  color: Colors.orangeAccent,
                                strokeWidth: 10,
                              ),
                            ),
                          ),
                          Shimmer(
                            // period :Duration(seconds: 4) ,
                            // baseColor: Colors.black.withOpacity(0.02),
                            // highlightColor: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  width: 200 ,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: 250 ,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  }
              ),
            ),
    );
  }
}
