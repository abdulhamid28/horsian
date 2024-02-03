import 'package:horsian/Resources/exports.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () async {
        setState(() => isPressed = true);
        await SignupScreenFunctionality.SignInUsingGoogleAccount().then(
            (userCredential) async => (userCredential == null)
                ? () {}
                : await SignupScreenFunctionality.StoreUserDataToFirebase(
                        userCredential: userCredential,
                        fullname: userCredential.user!.displayName!,
                        password: '')
                    .then((value) => (value)
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BaseScreen()))
                        : () {}));
        setState(() => isPressed = false);
        Toast.show('Signup Successful !',
            backgroundColor: KColor9, duration: 2);
      },
      splashColor: Colors.transparent,
      child: (isPressed)
          ? Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 7,
                  color: Colors.red,
                ),
              ),
            )
          : Image.asset(
              'asset/images/google png.png',
              width: 50,
              height: 50,
            ),
    );
  }
}
