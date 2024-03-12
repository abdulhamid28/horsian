import 'package:horsian/Resources/exports.dart';


class AddressWidget extends StatelessWidget {
  String addressId;
  String  recieverName ;
  String  type;
  String doorNumber ;
  String landmark;
  String streetName;
  String areaName;
  String cityName;
  String pincode;
  String contactNumber;
  String countryName;
  String stateName ;
  bool isEditAndDeleteVisible ;
   AddressWidget({
     required this.isEditAndDeleteVisible,
    required this.addressId,
    required this.recieverName,
    required this.type,
    required this.doorNumber,
    required this.landmark,
    required this.streetName,
    required this.areaName,
    required this.cityName,
    required this.pincode,
    required this.contactNumber,
    required this.countryName,
    required this.stateName,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
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
        (isEditAndDeleteVisible) ?SizedBox(height: 10,):SizedBox(),
        (isEditAndDeleteVisible) ? Row(
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
        ): SizedBox() ,
        (isEditAndDeleteVisible) ?SizedBox(height: 10,):SizedBox()
      ],
    );
  }
}



