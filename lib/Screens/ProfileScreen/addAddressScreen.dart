import 'package:horsian/Resources/exports.dart';
class AddAddressScreen extends StatefulWidget {

  bool isEditAddressTriggered ;
  String addressId ;

  AddAddressScreen({ required this.addressId, required this.isEditAddressTriggered});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  bool? isHomeClicked = false;
  bool? isFlatClicked = false;
  bool isAddButtonPressed = false;

  TextEditingController recieverController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  FocusNode recieverNameFocusNode =FocusNode();
  FocusNode contactNumberFocusNode =FocusNode();
  FocusNode doorNoFocusNode =FocusNode();
  FocusNode landmarkFocusNode =FocusNode();
  FocusNode streetNameFocusNode =FocusNode();
  FocusNode areaNameFocusNode =FocusNode();
  FocusNode cityNameFocusNode =FocusNode();
  FocusNode pincodeFocusNode =FocusNode();
  FocusNode stateNameFocusNode =FocusNode();
  FocusNode countryNameFocusNode =FocusNode();

  @override
  void initState() {
    if(widget.isEditAddressTriggered) loadData();
    super.initState();
  }

   loadData() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await AddressScreenFunctionality.getSpecificAddressData();
    List listOfAdress = snap.data()!['List_Address'];
    Map specificAddress = (listOfAdress.firstWhere((element) => element['Address_Id']==widget.addressId));
    recieverController.text = specificAddress['Reciever_Name'];
    doorNoController.text= specificAddress['Door_Number'];
    landMarkController.text = specificAddress['Landmark'];
    streetNameController.text= specificAddress['Street_Name'];
    areaNameController.text= specificAddress['Area_Name'];
    cityNameController.text= specificAddress['City_Name'];
    pinCodeController.text= specificAddress['Pincode'];
    stateNameController.text = specificAddress['State_Name'];
    countryNameController.text= specificAddress['Country_Name'];
    contactNumberController.text= specificAddress['Contact_Number'];

    if(specificAddress['Type'].contains('Home')) isHomeClicked = true;
    else isFlatClicked = true;

    setState(() {isHomeClicked;isFlatClicked;});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     recieverController.dispose();
     doorNoController.dispose();
     landMarkController.dispose();
     streetNameController.dispose();
     areaNameController.dispose();
     cityNameController.dispose();
     pinCodeController.dispose();
     stateNameController.dispose();
     countryNameController.dispose();
     contactNumberController.dispose();

      recieverNameFocusNode.dispose();
      contactNumberFocusNode.dispose();
      doorNoFocusNode.dispose();
      landmarkFocusNode.dispose();
      streetNameFocusNode.dispose();
      areaNameFocusNode.dispose();
      cityNameFocusNode.dispose();
      pincodeFocusNode.dispose();
      stateNameFocusNode.dispose();
      countryNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      'Add Address ',
                      style: TextStyle(
                          color: KColor9,
                          fontFamily: 'Axiforma',
                          fontSize: 25,height: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mention all the neccessary details to avoid confusion while delivering :)',
                      style: TextStyle(
                          color: KColor9,
                          fontFamily: 'Axiforma',
                          fontSize: 15),
                    ),
                    AddressTextField(
                        node : recieverNameFocusNode,
                        title: 'Reciever name',
                        hint: 'Abdul Hamid',
                        controller: recieverController,
                        type: TextInputType.name),
                    AddressTextField(
                        node : contactNumberFocusNode,
                        title: 'Phone number',
                        hint: '9840099095',
                        controller: contactNumberController,
                        type: TextInputType.number),
                    TypeSection(),
                    AddressTextField(
                        node: doorNoFocusNode,
                        title: 'Door no',
                        hint: '14B',
                        controller: doorNoController,
                        type: TextInputType.streetAddress),
                    AddressTextField(
                        node: landmarkFocusNode,
                        title: 'Landmark ',
                        hint: 'Near Sabari medicals',
                        controller: landMarkController,
                        type: TextInputType.streetAddress),
                    AddressTextField(
                        node: streetNameFocusNode,
                        title: 'Street name',
                        hint: 'Ptc colony',
                        controller: streetNameController,
                        type: TextInputType.streetAddress),
                    AddressTextField(
                        node: areaNameFocusNode,
                        title: 'Area name',
                        hint: 'Sembakkam ',
                        controller: areaNameController,
                        type: TextInputType.streetAddress),
                    AddressTextField(
                        node: cityNameFocusNode,
                        title: 'City ',
                        hint: 'Chennai ',
                        controller: cityNameController,
                        type: TextInputType.streetAddress),
                    AddressTextField(
                        node: pincodeFocusNode,
                        title: 'Pincode :',
                        hint: '600073 ',
                        controller: pinCodeController,
                        type: TextInputType.number),
                    AddressTextField(
                        node: stateNameFocusNode,
                        title: 'State ',
                        hint: 'Tamil nadu ',
                        controller: stateNameController,
                        type: TextInputType.name),
                    AddressTextField(
                        node: countryNameFocusNode,
                        title: 'Country',
                        hint: 'India',
                        controller: countryNameController,
                        type: TextInputType.name),
                    SaveAddressButton(context)
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  Material SaveAddressButton(BuildContext context) {
    return Material(
                    color: KColor9,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          setState(() => isAddButtonPressed = true);
                          if (AddressScreenFunctionality
                              .validateAddress(recieverName:
                              recieverController.text, phoneNumber:
                              contactNumberController.text,
                              doorNo: doorNoController.text,
                              streetName: streetNameController.text,
                              areaName: areaNameController.text,
                              cityName: cityNameController.text,
                              pincode: pinCodeController.text,
                              stateName: stateNameController.text,
                              countryName: countryNameController.text,
                              homeBool: isHomeClicked,
                              flatBool: isFlatClicked)) {
                            if(widget.isEditAddressTriggered== false){
                            AddressScreenFunctionality().addAddress(
                                recieverName:
                                recieverController.text,
                                contactNumber:
                                contactNumberController.text,
                                type: (isHomeClicked!)
                                    ? 'Home'
                                    : 'Flat',
                                doorNumber: doorNoController.text,
                                landMark: landMarkController.text,
                                streetName:
                                streetNameController.text,
                                areaName: areaNameController.text,
                                cityName: cityNameController.text,
                                pincode: pinCodeController.text,
                                stateName: stateNameController.text,
                                countryName:
                                countryNameController.text);
                            }
                            else{
                              AddressScreenFunctionality().editStoredAddress(
                                  recieverName:
                                  recieverController.text,
                                  contactNumber:
                                  contactNumberController.text,
                                  type: (isHomeClicked!)
                                      ? 'Home'
                                      : 'Flat',
                                  doorNumber: doorNoController.text,
                                  landMark: landMarkController.text,
                                  streetName:
                                  streetNameController.text,
                                  areaName: areaNameController.text,
                                  cityName: cityNameController.text,
                                  pincode: pinCodeController.text,
                                  stateName: stateNameController.text,
                                  countryName:
                                  countryNameController.text, addressId: widget.addressId);
                            }
                            Navigator.pop(context);
                          }
                          setState(() => isAddButtonPressed = false);
                        },
                        splashColor: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: (!isAddButtonPressed)
                              ? Text(
                            'Save Address',
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
                  );
  }

  Column TypeSection() {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          'Type',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,
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
                                  value: isHomeClicked,
                                  onChanged: (val) => setState(() {
                                      isHomeClicked = val;
                                      if (val! && isFlatClicked!) isFlatClicked = false;
                                    },
                                  ),
                                  activeColor: KColor5,
                                ),
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                    fontFamily: 'Axiforma',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: isFlatClicked,
                                  side: BorderSide(width: 2),
                                  onChanged: (val) {
                                    setState(() {
                                        isFlatClicked = val;
                                        if (val! && isHomeClicked!) isHomeClicked = false;
                                      },
                                    );
                                  },
                                  activeColor: KColor5,
                                ),
                              ),
                              Text(
                                'Flat',
                                style: TextStyle(
                                    fontFamily: 'Axiforma',
                                    fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
  }


  Widget AddressTextField({required controller, required title, required hint, required type , required FocusNode node}) {
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
                  fontSize: 16, fontFamily: 'Axiforma', color: KColor9, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 60,
            decoration: BoxDecoration(
                color: KColor3.withOpacity(.05),
                borderRadius: BorderRadius.circular(20),
                border: (node.hasFocus)? Border.all(color: KColor9): null
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: TextField(
                  onTap: ()=> setState(() => node.canRequestFocus),
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
