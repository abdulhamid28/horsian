
import 'package:horsian/Resources/exports.dart';

class ProfileScreenFunctionality {

  // static final listOfScreen = [
  //   AddressScreen(),
  //   PersonelInformationScreen(),
  //   OrdersScreen(),
  //   ChangePasswordScreen(),
  //   AddressScreen()];

  static Widget walletAndOrders({required int walletPoints , required int orderCount}) {return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              color: KColor9,
              elevation: 3,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: () {},
                //splashColor: KColor9.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${walletPoints}\n',
                              style: TextStyle(
                                  color: KColor5,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Axiforma'),
                            ),
                            TextSpan(
                              text: 'Points',
                              style: TextStyle(
                                  color: KColor8,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Axiforma'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Material(
              color: KColor9,
              elevation: 3,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${orderCount}\n',
                              style: TextStyle(
                                  color: KColor5,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Axiforma'),
                            ),
                            TextSpan(
                              text: 'Orders',
                              style: TextStyle(
                                  color: KColor8,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Axiforma'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );}

  static List<Widget> generateWidget() {
    List<Widget> temp = [];
    temp.add(const SizedBox(height: 10));
    for (int i = 0; i < ProfileWidgetList.length; i++) {
      temp.add(ProfileWidget(index: i),);
    }
    temp.add(const SizedBox(height: 10));
    return temp;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileData(){
    return firebaseFirestore.collection('UsersCollection').doc(firebaseAuth.currentUser!.email).snapshots();
  }


}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12),
      child: Material(
        elevation: 3,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () async {
            if(index==4){
              // RedirectingFunctionality.setDataInLocalFalse();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  await  SignupScreenFunctionality.signOutUser();
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileWidgetList[index].navigateTo)) ;
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
            width: double.maxFinite,
            height: 80,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Icon(
                      ProfileWidgetList[index].iconData,
                      size: 35,
                      color: KColor5,
                    )),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      ProfileWidgetList[index].h1Tag,
                        style: TextStyle(
                            height: 1,
                            color: KColor9,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Axiforma'),
                      ),
                      Text(
                        ProfileWidgetList[index].h2Tag,
                        style: TextStyle(
                            height: 1,
                            color: KColor8,
                            fontSize: 11,
                            fontFamily: 'Axiforma'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
