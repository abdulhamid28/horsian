import 'package:horsian/Resources/exports.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    AppBar appBar = AppBar(
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
    );
    ToastContext().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(   //todo :
                  tag: '1',
                  child: TitleAndAddButton(context)),
              AddressListSection(size, appBar, statusBarHeight)
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> AddressListSection(
      Size size, AppBar appBar, double statusBarHeight) {
    return StreamBuilder(
      stream: AddressScreenFunctionality().getStoredAddress(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List manageAddressList = snapshot.data!['List_Address'];
          if (manageAddressList.isEmpty)
            return SizedBox(
              width: double.maxFinite,
              height: size.height -
                  appBar.preferredSize.height -
                  statusBarHeight -
                  150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyBold.info_square,
                      color: KColor9,
                      size: 80,
                    ),
                    Text(
                      'No Data found ',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Axiforma',
                          fontSize: 16,
                          height: 1),
                    ),
                    Text(
                      'Click the below button to add Address ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Axiforma',
                          fontSize: 15,
                          fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              ),
            );
          else
            return SizedBox(
              width: double.maxFinite,
              height: size.height -
                  appBar.preferredSize.height -
                  statusBarHeight -
                  150,
              child: ListView.builder(
                itemCount: manageAddressList.length,
                itemBuilder: (context, index) {
                  return AddressWidget(
                      recieverName: manageAddressList[index]['Reciever_Name'],
                      type: manageAddressList[index]['Type'],
                      doorNumber: manageAddressList[index]['Door_Number'],
                      landmark: manageAddressList[index]['Landmark'],
                      streetName: manageAddressList[index]['Street_Name'],
                      areaName: manageAddressList[index]['Area_Name'],
                      cityName: manageAddressList[index]['City_Name'],
                      pincode: manageAddressList[index]['Pincode'],
                      contactNumber: manageAddressList[index]['Contact_Number'],
                      countryName: manageAddressList[index]['Country_Name'],
                      stateName: manageAddressList[index]['State_Name'],
                      addressId: manageAddressList[index]['Address_Id']);
                },
              ),
            );
        } else
          return SizedBox(
            width: double.maxFinite,
            height: size.height -
                appBar.preferredSize.height -
                statusBarHeight -
                150,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => ShimmerWidget(),
            ),
          );
      },
    );
  }

  SizedBox TitleAndAddButton(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage Address',
            style: TextStyle(
                fontFamily: 'Axiforma',
                fontWeight: FontWeight.bold,
                color: KColor9,
                fontSize: 20,
                height: 1),
          ),
          Text(
            'Here you can modify & manage all your address.',
            style: TextStyle(
                fontFamily: 'Axiforma',
                color: KColor9,
                fontSize: 14,
                height: 1),
          ),
          AddAddressButton(context),
        ],
      ),
    );
  }

  Padding AddAddressButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: KColor9,
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.maxFinite,
          height: 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressScreen(
                    addressId: '',
                    isEditAddressTriggered: false,
                  ),
                ),
              );
            },
            splashColor: Colors.white.withOpacity(.5),
            borderRadius: BorderRadius.circular(20),
            child: Center(
                child: Text(
              'Add Address',
              style: TextStyle(color: Colors.white, fontFamily: 'Axiforma'),
            )),
          ),
        ),
      ),
    );
  }

  Widget AddressWidget({
    required addressId,
    required recieverName,
    required type,
    required doorNumber,
    required landmark,
    required streetName,
    required areaName,
    required cityName,
    required pincode,
    required contactNumber,
    required countryName,
    required stateName,
  }) {
    return Column(
      children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage('asset/images/google map.png' ), fit: BoxFit.fill, opacity: 0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recieverName, //todo :
                        style: TextStyle(
                          fontFamily: 'Axiforma',
                          fontWeight: FontWeight.bold,
                          color: KColor9,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Type : ' + type,
                            style: TextStyle(
                                fontFamily: 'Axiforma',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Door no : ' + doorNumber,
                            style: TextStyle(
                                fontFamily: 'Axiforma',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                      Text(
                        'Landmark : ' + landmark,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        'Street name : ' + streetName,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        'Area name : ' + areaName,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        'City : ' + cityName + '  ' + 'Pincode : ' + pincode,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        'State : ' +
                            stateName +
                            '  ' +
                            'Country : ' +
                            countryName,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        'Contact no : ' + contactNumber,
                        maxLines: 1,
                        style: TextStyle(
                            fontFamily: 'Axiforma',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        IconlyBold.location,
                        color: Colors.red,
                        size: 40,
                      ))
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                elevation: 3,
                color: KColor9,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAddressScreen(
                          addressId: addressId,
                          isEditAddressTriggered: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconlyBold.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Axiforma'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Material(
                elevation: 3,
                color: KColor9,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    AddressScreenFunctionality()
                        .deleteStoredAddress(addressId: addressId);
                  },
                  child: Container(
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconlyBold.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Axiforma'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
