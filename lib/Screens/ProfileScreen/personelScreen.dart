import 'package:horsian/Functionality/PersonelScreenFunctionality/personelScreenFunctions.dart';
import 'package:horsian/Resources/exports.dart';

class PersonelInformationScreen extends StatefulWidget {
  @override
  State<PersonelInformationScreen> createState() =>
      _PersonelInformationScreen();
}

class _PersonelInformationScreen extends State<PersonelInformationScreen> {
  bool? isMaleClicked = false;
  bool? isFemaleClicked = false;
  bool isUpdateButtonPressed = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    loadData();

    super.initState();
  }

  void loadData() async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await PersonelInformationScreenFunctionality.get();
    nameController.text = snap.data()!['User_Name'];
    contactNumberController.text = snap.data()!['Phone_Number'];
    String gender = snap.data()!['User_Gender'];
    if (gender != 'Not Mentioned') {
      if (gender == 'Male') {
        isMaleClicked = true;
        isFemaleClicked = false;
      } else {
        isFemaleClicked = true;
        isMaleClicked = false;
      }
      setState(() {
        isMaleClicked; isFemaleClicked;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: double.maxFinite,
            color: Colors.white,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personel Information',
                    style: TextStyle(
                        color: KColor9,
                        fontFamily: 'Axiforma',
                        fontSize: 25,
                        height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Mention all the neccessary details to complete Signup:)',
                      style: TextStyle(
                          color: KColor9, fontFamily: 'Axiforma', fontSize: 15),
                    ),
                  ),
                  CustomTextField(
                      controller: nameController,
                      title: 'Name',
                      hint: 'Abdul hamid',
                      type: TextInputType.name,
                      node: nameFocusNode),
                  CustomTextField(
                      controller: contactNumberController,
                      title: 'Contact Number',
                      hint: '9840099095',
                      type: TextInputType.number,
                      node: contactNumberFocusNode),
                  GenderSex(),
                  UpdateDetailsButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget UpdateDetailsButton() {
    return Padding(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Material(
                    color: KColor9,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isUpdateButtonPressed = true;
                          });
                          await PersonelInformationScreenFunctionality
                              .updatePersonelDetails(
                                  name: nameController.text,
                                  contactNumber: contactNumberController.text,
                                  sex: (isMaleClicked! || isFemaleClicked!)
                                      ? ((isMaleClicked!) ? "Male" : "Female")
                                      : "Not Mentioned");
                          setState(() {
                            isUpdateButtonPressed = false;
                          });
                        },
                        splashColor: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: (!isUpdateButtonPressed)
                              ? Text(
                                  'Update Details',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Axiforma',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ),
                );
  }

  Widget GenderSex() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        'Gender/Sex',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Axiforma',
                            color: KColor9),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                side: BorderSide(width: 2),
                                value: isMaleClicked,
                                onChanged: (val) => setState(
                                  () {
                                    isMaleClicked = val;
                                    if (val! && isFemaleClicked!) {
                                      isFemaleClicked = false;
                                    }
                                  },
                                ),
                                activeColor: KColor5,
                              ),
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                  fontFamily: 'Axiforma', fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: isFemaleClicked,
                                side: BorderSide(width: 2),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      isFemaleClicked = val;
                                      if (val! && isMaleClicked!) {
                                        isMaleClicked = false;
                                      }
                                    },
                                  );
                                },
                                activeColor: KColor5,
                              ),
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                  fontFamily: 'Axiforma', fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
  }

  Widget CustomTextField({required TextEditingController controller, required String title, required String hint, required TextInputType type, required FocusNode node}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Axiforma',
                  color: KColor9,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 60,
            decoration: BoxDecoration(
                color: KColor3.withOpacity(.05),
                borderRadius: BorderRadius.circular(20),
                border: (node.hasFocus) ? Border.all(color: KColor9) : null),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: TextField(
                    onTap: () => setState(() => node.canRequestFocus),
                    focusNode: node,
                    keyboardType: type,
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'eg.' + hint,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.withOpacity(.9)),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
