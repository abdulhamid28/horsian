import 'package:horsian/Functionality/resetPasswordScreenFunctions.dart';
import 'package:horsian/Resources/exports.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isEmailValid = false;
  bool isResetButtonPressed = false ;
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameFocusnode.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              IconlyLight.arrow_left_2,
              size: 30,
              color: KColor9,
            )),
        title: Icon(
          IconlyBold.home,
          size: 30,
          color: KColor9,
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderCard(),
          RequestTextField(),
          RequestLinkButton(context)
        ],
      ),
    );
  }

  Widget RequestTextField() {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.maxFinite,
            height: 60,
            decoration: BoxDecoration(
                color: KColor3.withOpacity(.05),
                borderRadius: BorderRadius.circular(20),
                border: (usernameFocusnode.hasFocus == true)
                    ? Border.all(color: KColor9)
                    : null),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    focusNode: usernameFocusnode,
                    controller: usernameController,
                    onTap: () => setState(
                          () => usernameFocusnode.requestFocus(),
                        ),
                    onChanged: (val) => setState(
                          () => isEmailValid = LoginScreenFunctionality()
                              .emailValidation(email: val),
                        ),
                    style: TextStyle(
                        color:
                            (isEmailValid == true) ? KColor9 : Colors.red),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter email address',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.withOpacity(.9)),
                        icon: Icon(
                          IconlyBold.shield_done,
                          size: 30,
                          color: KColor9,
                        ))),
              ),
            ),
          ),
        );
  }

  Widget RequestLinkButton(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            color: KColor9 ,
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.maxFinite,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () async {
                  setState(() {isResetButtonPressed = true ;});
                  await ResetPasswordScreenFuntionality.requestResetPassword(email: usernameController.text.trim()).then(
                          (value) =>(!value) ? (){}:  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
                 // RedirectingFunctionality.setDataInLocalFalse();
                  setState(() {isResetButtonPressed = false ;});
                },
                splashColor: Colors.white.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: (!isResetButtonPressed) ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Request Link',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Axiforma'
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Icon(IconlyLight.send , color: Colors.white, size: 25,)
                      )
                    ],
                  ) :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Link sent',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Axiforma'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Icon(IconlyBold.send , color: Colors.white, size: 25,)
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }

  Widget HeaderCard() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'asset/images/horsian logo white no text.png',
              width: 120,
              height: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: KColor9,
                    fontFamily: 'Axiforma',
                  ),
                ),
                Text(
                  'We send you a reset link to your\nemail account.',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 10, color: KColor9,
                    fontFamily: 'Axiforma',
                  ),
                ),
              ],
            ),
          ],
        );
  }
}
