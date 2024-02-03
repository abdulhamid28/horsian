import 'package:horsian/Resources/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true ; // TODO: password eye
  bool isEmailValid = false; //  TODO: textfield for email validator

  bool isLoginButtonPressed = false ; // TODO:  bool for signup button action

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusnode = FocusNode();
  FocusNode passwordFocusnode = FocusNode();
  InternetStatus current = InternetStatus.connected;
  @override
  void dispose() {
    usernameController.dispose();passwordController.dispose();
    usernameFocusnode.dispose();passwordFocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ConnectivityShow(),
                  HeaderCard(), // TODO: Done
                  Username(), // TODO: Done
                  Password(), // TODO: Done
                  ForgotPassword(), // TODO: Done
                  LoginButton(), // TODO: Done
                  SigninOptions(), // TODO: Done
                  SignupButton(context) // TODO: Done
              ],
            ),
          ),
        ),
      )
    );
  }



  Widget SignupButton(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?' ,
                    style: TextStyle(
                      fontFamily: 'Axiforma',
                      color: KColor3.withOpacity(0.5),
                      fontWeight: FontWeight.w100
                    ),
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap:()  {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                      },
                      child: Text('Sign up' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontFamily: 'Axiforma',
                          fontSize: 17,
                          color: KColor9
                        ),
                      ),
                    )
                  ],
                );
  }

  Widget SigninOptions()=> Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: KColor9,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left :8.0 , right : 8),
                    child: Text('Signin with ',
                      style: TextStyle(
                          fontFamily: 'Axiforma'
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: KColor9,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            GoogleSignInButton(context: context)
                    ],
                  ),
                );

  Widget LoginButton()=> Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  color: KColor9,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      onTap: () async {
                        if(LoginScreenFunctionality.isDataSufficient(email: usernameController.text, password: passwordController.text)){
                           setState(()=>isLoginButtonPressed = true);
                           await LoginScreenFunctionality.loginUserUsingUserIdAndPassword(
                               email: usernameController.text.trim(),
                               password: passwordController.text.trim()).then(
                                   (userCredential) =>
                                       (userCredential == null)? (){}:
                                           Navigator.pushReplacement(context, MaterialPageRoute(
                                               builder: (context)=>BaseScreen()))

                               );
                           setState(()=>isLoginButtonPressed = false);
                        }
                      },
                      splashColor: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child:(!isLoginButtonPressed)?
                        Text(  'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Axiforma'
                        ),
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Signing up  ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Axiforma'
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: 20,height: 20,
                                  child: CircularProgressIndicator(color: Colors.white,)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );

  Widget ForgotPassword()=> GestureDetector(
    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen())),
    child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Forgot Password ? ',
                        style: TextStyle(
                          fontFamily: 'Axiforma',
                          color: KColor9
                          ),
                        ),
                    ),
                  ),
  );

  Widget Password()=> Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Password' ,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Axiforma',
                          color: KColor9
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                         color: KColor3.withOpacity(.05),
                         borderRadius: BorderRadius.circular(20,),
                         border: (passwordFocusnode.hasFocus == true ) ? Border.all(color: KColor9) : null
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Center(
                          child: TextField(
                            focusNode: passwordFocusnode,
                            controller: passwordController,
                            onTap: ()=>  setState(() => passwordFocusnode.requestFocus(),),
                            obscureText: isVisible,
                              style: TextStyle(color: KColor9),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'atleast 6 characters',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey.withOpacity(.9)),
                                  icon: Icon(IconlyBold.unlock , size: 30, color: KColor9,),
                                  suffixIcon: (passwordFocusnode.hasFocus)?
                                  Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: GestureDetector(
                                      onTap: ()=> setState(() =>
                                          isVisible = (isVisible == true) ? false : true),
                                      child: Icon(
                                        (isVisible)? IconlyBold.show :  IconlyBold.hide, size: 30, color: KColor9,)),
                                 ): null
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );

  Widget Username()=> Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Username' , style: TextStyle(fontSize: 16, fontFamily: 'Axiforma', color: KColor9),),
                      Container(
                        width: double.maxFinite,
                        height: 60,
                        decoration: BoxDecoration(
                          color: KColor3.withOpacity(.05),
                          borderRadius: BorderRadius.circular(20),
                          border: (usernameFocusnode.hasFocus==true)? Border.all(color: KColor9):null
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              focusNode: usernameFocusnode,
                              controller: usernameController,
                              onTap: ()=>  setState(() => usernameFocusnode.requestFocus(),),
                              onChanged: (val)=>setState(() =>isEmailValid =  LoginScreenFunctionality().emailValidation(email: val),), style: TextStyle(color: (isEmailValid== true ) ?  KColor9 : Colors.red ),
                              decoration: InputDecoration(
                               border: InputBorder.none,
                               hintText: 'eg.abcd@gmail.com',
                               hintStyle: TextStyle(
                               fontWeight: FontWeight.w300,
                               color: Colors.grey.withOpacity(.9)),
                               icon: Icon(IconlyBold.shield_done , size: 30, color: KColor9,)
                             )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );

  Widget HeaderCard()=>Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Hey' ,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Axiforma',
                            ),),
                          SizedBox(width: 10,),
                          Text('Horsian' ,
                            style: TextStyle(
                                fontSize: 44,
                              fontFamily: 'Axiforma',
                              fontWeight: FontWeight.bold,
                              color: KColor9
                            ),),
                        ],
                      ),
                      Text('We missed you.!' ,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Axiforma',
                        ),),
                    ],
                  ),
                );
}
