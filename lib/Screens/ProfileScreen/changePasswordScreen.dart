import 'package:horsian/Functionality/AuthenticationFunctionality/resetPasswordScreenFunctions.dart';
import 'package:horsian/Resources/exports.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isUpdateButtonPressed = false ;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode oldPasswordFocusnode = FocusNode();
  FocusNode newPasswordFocusnode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newPasswordController.dispose();
    oldPasswordFocusnode.dispose();
    oldPasswordController.dispose();
    newPasswordFocusnode.dispose();
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
              IconlyLight.arrow_left_2, size: 30, color: KColor9,),
        ),
        title: Icon(
          IconlyBold.home,
          size: 30,
          color: KColor9,
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderTitleCard(),
              PasswordWidget(
                  node: oldPasswordFocusnode,
                  controller: oldPasswordController,
                  hint: 'Old password credential',
                  iconData: IconlyLight.password),
              PasswordWidget(
                  node: newPasswordFocusnode,
                  controller: newPasswordController,
                  hint: 'New password credential',
                  iconData: IconlyBold.password),
              UpdatePasswordButton(),
              Text('Or',style: TextStyle(
                fontFamily: 'Axiforma', fontWeight: FontWeight.bold,
                color: KColor9,
              ),),
              SizedBox(height: 10,),
              Text('if password is forgotten',style: TextStyle(
                fontFamily: 'Axiforma',
                color: KColor9,
              ),),
              ForgotPasswordButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding ForgotPasswordButton(BuildContext context) {
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
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen())),
                    splashColor: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forgot Password',
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
                    ),
                  ),
                ),
              ),
            );
  }

  Padding UpdatePasswordButton() {
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
                      setState(() {isUpdateButtonPressed = true ;});
                      ResetPasswordScreenFuntionality.changePassword(
                          emailId: firebaseAuth.currentUser!.email!,
                          oldPassword: oldPasswordController.text.trim(), newPassword: newPasswordController.text.trim());
                      setState(() {isUpdateButtonPressed = false ;});

                    },
                    splashColor: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                      child:(!isUpdateButtonPressed)?  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Update Password',
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
                      ) :  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: CircularProgressIndicator( color:  Colors.white, strokeWidth: 4,),
                       )
                      ],
                    )
                    ),
                  ),
                ),
              ),
            );
  }

  Padding PasswordWidget({required FocusNode node , required TextEditingController controller , required String hint , required IconData iconData}) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.maxFinite,
                height: 60,
                decoration: BoxDecoration(
                    color: KColor3.withOpacity(.05),
                    borderRadius: BorderRadius.circular(20),
                    border: (node.hasFocus == true)
                        ? Border.all(color: KColor9)
                        : null),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Center(
                    child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: node,
                        controller: controller,
                        onTap: () => setState(() => node.requestFocus(),),
                        style: TextStyle(
                            color: KColor9 ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:  hint , //'Old password credential',  // todo
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,  // todo :
                                color: Colors.grey.withOpacity(.9)),
                            icon: Icon(
                              iconData,   //todo
                              size: 30,
                              color: KColor9,
                            ))),
                  ),
                ),
              ),
            );
  }

  Row HeaderTitleCard() {
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
                      'Change Password',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,

                        color: KColor9,
                        fontFamily: 'Axiforma',
                      ),
                    ),
                    Text(
                      'Authenticating user for updating\nnew password.',
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
