import 'package:horsian/Resources/exports.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
              TitleAndAddButton(),
              OrderSection(size, appBar, statusBarHeight)
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> OrderSection(
      Size size, AppBar appBar, double statusBarHeight) {
    return StreamBuilder(
      stream: AddressScreenFunctionality().getStoredAddress(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List OrderCurrentList = snapshot.data!['Order_Current'];
          List OrderHistoryList = snapshot.data!['Order_History'];
          if (OrderCurrentList.isEmpty && OrderHistoryList.isEmpty)
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
                      IconlyBold.bag_2,
                      color: KColor9,
                      size: 80,
                    ),
                    Text(
                      'No History of Orders found ',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Axiforma',
                          fontSize: 16,
                          height: 1),
                    ),
                  ],
                ),
              ),
            );
          else {
            return SizedBox(
              width: double.maxFinite,
              height: size.height -
                  appBar.preferredSize.height -
                  statusBarHeight -
                  180,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Orders on the way ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Axiforma',
                          fontWeight: FontWeight.bold,
                          color: KColor9,
                          fontSize: 20,
                          height: 1),
                    ),
                    SizedBox(height: 5),
                    // (OrderCurrentList.length==0)? Text('No current orders',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       fontFamily: 'Axiforma',
                    //       color: KColor9,
                    //       fontSize: 14,
                    //       height: 1),
                    // ): SizedBox() ,
                    ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: OrderCurrentList.length,
                      //OrderCurrentList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom :10.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                            color: Colors.white,
                            child: Container(
                              height: 140,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: GestureDetector(
                                      onTap:(){
                                        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>
                                            ProductScreen(
                                                productScreenReq: ProductScreenRequired(
                                                    productName: OrderCurrentList[index]['Product_Name'],
                                                    categoryType: OrderCurrentList[index]['Product_Category'],
                                                    brandName: OrderCurrentList[index]['Product_Brand']))));
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.network(
                                               OrderCurrentList[index]['Product_Banner'],
                                                loadingBuilder: (context,child,chunk){
                                                 if(chunk!=null){
                                                   return CircularProgressIndicator(
                                                     color: KColor9,
                                                   );
                                                 }else return child;
                                                } ,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Center(
                                                child: Icon(
                                              IconlyBold.bag_2,
                                              size: 80,
                                              color: Colors.orangeAccent
                                                  .withOpacity(0.5),
                                            )),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 15.0),
                                                child: Text(
                                                  "Purchased",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Axiforma',
                                                      fontSize: 9),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Shimmer(
                                            colorOpacity: 0.6,
                                            color: Colors.white,
                                            child: Material(
                                              elevation: 3,
                                              color: Colors.red[900],
                                              child: Container(
                                                height: 35,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'ORDER ID ',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Axiforma'),
                                                    ),
                                                    Text(
                                                    OrderCurrentList[index]['Product_ID'].toString().substring(0,6),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontFamily: 'Axiforma'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            OrderCurrentList[index]['Product_Name'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Axiforma',
                                                color: KColor9,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            'Size :' + '${OrderCurrentList[index]['Product_Size']}',
                                            style: TextStyle(
                                                fontSize: 12,fontFamily: 'Axiforma',
                                                height: .8, color: Colors.blueGrey),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Status: ',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Axiforma',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                OrderCurrentList[index]['Order_Status'],
                                                style: GoogleFonts.anton(
                                                    textStyle: TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'History of Orders',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Axiforma',
                          fontWeight: FontWeight.bold,
                          color: KColor9,
                          fontSize: 20,
                          height: 1),
                    ),
                    SizedBox(height: 5),
                    (snapshot.data!['Order_History'].length == 0)
                        ? Text(
                            'No History of purchase',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Axiforma',
                                color: KColor9,
                                fontSize: 14,
                                height: 1),
                          )
                        : SizedBox(),
                    ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!['Order_History'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.red,
                          height: 100,
                          width: 50,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        } else
          return SizedBox(
            // todo : loading
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

  SizedBox TitleAndAddButton() {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Orders',
            style: TextStyle(
                fontFamily: 'Axiforma',
                fontWeight: FontWeight.bold,
                color: KColor9,
                fontSize: 20,
                height: 1),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            'Here you can find the orders on the way and previously purchased shoes.',
            style: TextStyle(
                fontFamily: 'Axiforma',
                color: KColor9,
                fontSize: 14,
                height: 1),
          ),
        ],
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
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
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
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
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
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () async {
                    AddressScreenFunctionality()
                        .deleteStoredAddress(addressId: addressId);
                  },
                  child: Container(
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
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
