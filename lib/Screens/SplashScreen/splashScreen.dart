import 'package:flutter/scheduler.dart';

import 'package:horsian/Resources/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> fetchData() async {
  //
  //     await  RedirectingFunctionality.checkDataExistInLocal().then(
  //             (value) async {
  //               if(value != null && value == true) {
  //                List<String>?  credList = await  RedirectingFunctionality.retriveLocalDataForNativeProvider();
  //                print(credList![0]);
  //                     rootClass.firebaseAuth.signInWithEmailAndPassword(
  //                         email: credList![0], password: credList[1]).then((value) =>
  //                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BaseScreen()))
  //
  //                         );
  //               }else{
  //                 Navigator.pushReplacement(context,
  //                     MaterialPageRoute(builder: (context) => OnboardingScreen()));
  //               }
  //
  //             }
  //     );
  //
  //   //   SchedulerBinding.instance.addPostFrameCallback(
  //   //     (_) {
  //   //
  //   //
  //   //       }
  //   // );
  //
  // }

  // void temp(){
  //   firebaseAuth.authStateChanges().listen((currentUserCheck) {
  //        if(currentUserCheck!=null && currentUserCheck!.uid!=null){
  //          // AuthCredential authCredential = EmailAuthProvider.credential(email: '123@gmail.com', password: '123457');
  //          // rootClass.userCredential = rootClassreauthenticateWithCredential(authCredential);
  //          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BaseScreen()));
  //        }else Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()));
  //   });
  // }


  @override
  void initState() {
    //fetchData();
   // temp();
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,

        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            width: 160,
            height: 160,
            child: Image.asset('asset/images/horsian logo white.png')),
      ),
    );
  }
}
