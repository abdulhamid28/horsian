import 'package:horsian/Resources/exports.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisiblePassword = true ;   //  TODO:  password eye
  bool isVisibleRepassword = true ; //  TODO:  re-password eye
  bool isEmailValid = false;        //  TODO: textfield for email validator
  bool isSignupButtonPressed = false ; // TODO:  bool for signup button action

  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  FocusNode fullnameFocusnode = FocusNode();
  FocusNode usernameFocusnode = FocusNode();
  FocusNode passwordFocusnode = FocusNode();
  FocusNode repasswordFocusnode = FocusNode();

  @override
  void dispose() {
    fullnameController.dispose();usernameController.dispose();passwordController.dispose();repasswordController.dispose();
    fullnameFocusnode.dispose();usernameFocusnode.dispose();passwordFocusnode.dispose();repasswordFocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
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
                  Fullname(), // TODO: Done
                  Username(), // TODO: Done
                  Password(), // TODO: Done
                  Repassword(), // TODO: Done
                  SignupButton(), // TODO: Done
                  SignupOptions(), // TODO: Done
                  LoginButton(context) // TODO: Done
                ],
              ),
            ),
          ),
        )
    );
  }


  Widget HeaderCard() => Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Create Account' ,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            color: KColor9
                        ),
                      ),
                      Text('We\'re glad to have you!' ,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Axiforma',
                        ),
                      ),
                    ],
                  ),
                );

  Widget Fullname() => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Fullname' , style: TextStyle(fontSize: 16, fontFamily: 'Axiforma', color: KColor9),),
                      Container(
                        width: double.maxFinite,
                        height: 60,
                        decoration: BoxDecoration(
                            color: KColor3.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                            border: (fullnameFocusnode.hasFocus==true)? Border.all(color: KColor9):null
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: TextField(
                                keyboardType: TextInputType.name,
                                focusNode: fullnameFocusnode,
                                controller: fullnameController,
                                onTap: ()=>  setState(() => fullnameFocusnode.requestFocus(),),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg.abdul hamid',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.withOpacity(.9)),
                                    icon: Icon(IconlyBold.profile , size: 30, color: KColor9,)
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );

  Widget Username() => Padding(
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
                            border: (usernameFocusnode.hasFocus)? Border.all(color: KColor9):null
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                focusNode: usernameFocusnode,
                                controller: usernameController,
                                onTap: ()=>  setState(() => usernameFocusnode.requestFocus(),),
                                onChanged: (val){
                                  setState(() {
                                    isEmailValid = LoginScreenFunctionality().emailValidation(email: val);
                                  });
                                },
                                style: TextStyle(
                                    color: (isEmailValid) ?  KColor9 : Colors.red
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg.abdulhamid@gmail.com',
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

  Widget Password() => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Password' ,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Axiforma',
                            color: KColor9
                        ),),
                      Container(
                        width: double.maxFinite,
                        height: 60,
                        decoration: BoxDecoration(
                            color: KColor3.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20,),
                            border: (passwordFocusnode.hasFocus) ? Border.all(color: KColor9) : null
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: TextField(
                                focusNode: passwordFocusnode,
                                controller: passwordController,
                                onTap: ()=>  setState(() => passwordFocusnode.requestFocus(),),
                                obscureText: isVisiblePassword,
                                style: TextStyle(color: KColor9),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'atleast 6 characters',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.withOpacity(.9)),
                                    icon: Icon(IconlyBold.unlock , size: 30, color: KColor9,),
                                    suffixIcon: (passwordFocusnode.hasFocus) ?
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: (){
                                            setState(() =>
                                            isVisiblePassword = (isVisiblePassword) ? false : true);
                                          },
                                          child: Icon(
                                            (isVisiblePassword)? IconlyBold.show :  IconlyBold.hide, size: 30, color: KColor9,)),
                                    ) : null
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );

  Widget Repassword() => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Re-Enter Password' ,
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
                            border: (repasswordFocusnode.hasFocus) ? Border.all(color: KColor9) : null
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: TextField(
                                obscureText: isVisibleRepassword,
                                focusNode: repasswordFocusnode,
                                controller: repasswordController,
                                onTap: ()=>  setState(() => repasswordFocusnode.requestFocus(),),
                                style: TextStyle(color: KColor9),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'atleast 6 characters',
                                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey.withOpacity(.9)),
                                    icon: Icon(IconlyBold.unlock , size: 30, color: KColor9,),
                                    suffixIcon: (repasswordFocusnode.hasFocus) ?
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: GestureDetector(
                                          onTap: ()=> setState(()=> isVisibleRepassword=(isVisibleRepassword) ? false : true),
                                          child: Icon(
                                            (isVisibleRepassword)? IconlyBold.show :  IconlyBold.hide, size: 30, color: KColor9,)),
                                    ): null
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );

  Widget SignupButton() => Padding(
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
                          setState(() => isSignupButtonPressed = true);
                          //ToDo : This function is completed and perfect
                          if(await SignupScreenFunctionality.customConnectivityCheck() && SignupScreenFunctionality.isDataSufficient(
                               name: fullnameController.text, email: usernameController.text,
                               password: passwordController.text, repassword: repasswordController.text) ) {
                               await  SignupScreenFunctionality.CreateUser(
                                    email: usernameController.text.trim(),
                                    password: passwordController.text.trim()
                               ).then((userCredential) async =>(userCredential==null)? (){}:
                                    await SignupScreenFunctionality.StoreUserDataToFirebase(
                                       userCredential: userCredential,
                                       fullname : fullnameController.text,
                                       password :passwordController.text).then((returnValue) => (!returnValue)? (){}:
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BaseScreen()))
                                    )
                               );
                          }
                          setState(() => isSignupButtonPressed = false);
                        },
                        splashColor: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: (!isSignupButtonPressed) ? Text('Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Axiforma'
                            ),
                          ) :
                          Row(
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

  Widget SignupOptions() => Padding(
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
                              child: Text('Signup with ',
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

  Widget LoginButton(BuildContext context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?' ,
                      style: TextStyle(
                          fontFamily: 'Axiforma',
                          color: KColor3.withOpacity(0.5),
                          fontWeight: FontWeight.w100
                      ),
                    ),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap:() {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen() ) );
                      },
                      child: Text('Login in' ,
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

