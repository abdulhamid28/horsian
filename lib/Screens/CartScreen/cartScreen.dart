import 'package:horsian/PaymentProcess/stripePaymentProcessing.dart';
import 'package:horsian/Resources/exports.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = CartController();
  //PageController pageController = PageController();
  int activeStep = 0;
  late AddressWidget shippingAddress ;
  int selectedShippingAddress = 999;
  int selectedBillingAddress = 999;
  late AddressWidget billingAddress ;
  int totalAmountToBeDetected=0;

  void onDragUpdateAction(DragUpdateDetails details) {
    if (details.primaryDelta! < 0)
      cartController.setShow(currentShow: CurrentShow.cartScreen);
    else
      cartController.setShow(currentShow: CurrentShow.proceedScreen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //pageController.dispose();
    cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            IconlyLight.arrow_left_2,
            size: 30,
            color: KColor9,
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
              color: KColor9,
              fontFamily: 'Axiforma',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: AnimatedBuilder(
          animation: cartController,
          builder: (context, _) {
            return LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: StreamBuilder(
                    stream: CartScreenFunctionality.getCart(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:(
                                      snapshot.data!['User_Cart'].length != 0)
                                      ? Column(
                                          children: List.generate(
                                            snapshot.data!['User_Cart'].length,
                                            (index) => CartData(
                                              index: index,
                                              snapshot: snapshot.data!['User_Cart'][index],
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Center(
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(20)),
                                                child: Icon(
                                                  IconlyLight.buy,
                                                  size: 65,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Your Shopping cart is awaiting for you',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Axiforma',
                                                  color: Colors.blueGrey.shade100),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            (snapshot.data!['User_Cart'].length != 0)
                                ? AnimatedPositioned(
                                    duration: Duration(milliseconds: 300),
                                    left: 0,
                                    right: 0,
                                    top: (cartController.getShow() == CurrentShow.proceedScreen) ? constraints.maxHeight - 100 : 50,
                                    height: constraints.maxHeight - 50,
                                    child: GestureDetector(
                                        onVerticalDragUpdate: (details) {onDragUpdateAction(details);},
                                        child: (cartController.getShow() != CurrentShow.proceedScreen)
                                            ? AnimatedContainer(
                                                duration: Duration(milliseconds: 300),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: Colors.blueGrey,
                                                        width: 2,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    StepperWidget(activeStep: activeStep),
                                                    SizedBox(
                                                      height: (constraints.maxHeight - 260),
                                                      child: (activeStep==0)? ProductProceed(snapshot: snapshot, constraints: constraints):
                                                      (activeStep==1)?AddressProceed(context):CheckOutProceed(amount: totalAmountToBeDetected)
                                                    ),
                                                    Material(
                                                      color: KColor9,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius.circular(20),
                                                              topRight: Radius.circular(20)),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.only(topLeft: Radius.circular(20),
                                                                topRight: Radius.circular(20)),
                                                        onTap: ()async{
                                                             if(activeStep==0){
                                                               totalAmountToBeDetected = CartScreenFunctionality.calculateTotalAmount(
                                                                   product: snapshot.data!['User_Cart']).toInt();
                                                               setState(() {
                                                                 ++activeStep;
                                                               });
                                                             }
                                                             else if(activeStep==1){
                                                                    if(selectedShippingAddress!=999 && selectedBillingAddress!=999){
                                                                      setState(() {
                                                                        ++activeStep;
                                                                      });
                                                                    }else{
                                                                      Toast.show('Select Shipping/Billing Address',
                                                                          backgroundColor: KColor9,
                                                                          duration: 2,
                                                                          gravity:1
                                                                      );
                                                                    }
                                                             }else if(activeStep==2){// caclulate payment
                                                                 StripePaymentGateway.makePayment(
                                                                   context: context,
                                                                   snapshot: snapshot.data!['User_Cart'],
                                                                   cartController: cartController,
                                                                     amount: ((totalAmountToBeDetected/80)+(totalAmountToBeDetected/80)*0.029 +7).toInt().toString(),
                                                                     currency: 'USD');
                                                              // CartScreenFunctionality.updateProductDatabase(userCart: snapshot.data!['User_Cart']);
                                                             }
                                                          },
                                                        child: Container(
                                                          height: 90,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(20),
                                                                  topRight: Radius.circular(20))),
                                                          child: Center(
                                                            child: Text(
                                                              'Proceed next !',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'Axiforma',
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius.circular(20),
                                                          topRight: Radius.circular(20)),
                                                  color: KColor9,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 30),
                                                  child: Text(
                                                    'Swipe up to proceed',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Axiforma',
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                  )
                                : SizedBox()
                          ],
                        );
                      else return Column(
                          children: [
                            Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  IconlyLight.buy,
                                  size: 65,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Text(
                              'Your Shopping cart is loading for you',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Axiforma',
                                  color: Colors.blueGrey.shade100),
                            )
                          ],
                        );
                    }),
              );
            });
          }),
    );
  }

  Widget AddressProceed(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Material(
              color: KColor9,
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child:
                  Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              AddAddressScreen(addressId: '', isEditAddressTriggered: false,
                          ),
                        ),
                      );
                    },
                  splashColor: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                      child: Text('Add Address',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Axiforma'),
                  ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text('Select the billing Address',
            style: TextStyle(
              fontFamily: 'Axiforma',
              color: Colors.blueGrey,
              fontSize: 16
            ),
            ),
          ),
          Container(
              height: 300,
              width: double.maxFinite,
              child: StreamBuilder(
                stream: AddressScreenFunctionality()
                    .getStoredAddress(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    List manageAddressList = snapshot.data!['List_Address'];
                    return ListView.builder(
                      itemCount: snapshot.data!['List_Address'].length,
                      itemBuilder: (context, index){
                        AddressWidget address =   AddressWidget(
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
                          addressId: manageAddressList[index]['Address_Id'],
                          isEditAndDeleteVisible: false,);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: GestureDetector(
                            onTap:(){
                              selectedShippingAddress = index;
                              shippingAddress= address;
                              setState(() {
                                selectedShippingAddress;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular( 25),
                                    border: Border.all(
                                      width:
                                      (selectedShippingAddress==index)? 4: 0,
                                        color: Colors.blueGrey
                                    )),
                                child: address),
                          ),
                        );
                      },
                    );
                  }else return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ShimmerWidget(),
                  );
                },
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text('Select the shipping Address',
              style: TextStyle(
                  fontFamily: 'Axiforma',
                  color: Colors.blueGrey,
                  fontSize: 16
              ),
            ),
          ),
          Container(
              height: 300,
              width: double.maxFinite,
              child: StreamBuilder(
                stream: AddressScreenFunctionality()
                    .getStoredAddress(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    List manageAddressList = snapshot.data!['List_Address'];
                    return ListView.builder(
                      itemCount: snapshot.data!['List_Address'].length,
                      itemBuilder: (context, index){
                        AddressWidget address =   AddressWidget(
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
                          addressId: manageAddressList[index]['Address_Id'],
                          isEditAndDeleteVisible: false,);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: GestureDetector(
                            onTap:(){
                              selectedBillingAddress = index;
                              billingAddress= address;
                              setState(() {
                                selectedBillingAddress;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular( 25),
                                    border: Border.all(
                                        width:
                                        (selectedBillingAddress==index)? 4: 0,
                                        color: Colors.blueGrey
                                    )),
                                child: address),
                          ),
                        );
                      },
                    );
                  }else return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ShimmerWidget(),
                  );
                },
              )
          ),
        ],
      ),
    );
  }

}

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    required this.activeStep,
  });

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          //  color: KColor9,
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 12),
          child: EasyStepper(
            lineStyle: LineStyle(
                lineType: LineType.normal,
                lineThickness: 2,
                defaultLineColor: Colors.grey,
                finishedLineColor: Colors.green[800]),
            borderThickness: 4,
            stepRadius: 30,
            fitWidth: false,
            activeStep: activeStep,
            disableScroll: true,
            showLoadingAnimation:false,
            activeStepIconColor: KColor9,
            activeStepBackgroundColor: Colors.white,
            activeStepBorderType:BorderType.normal,
            activeStepBorderColor:KColor9,
            defaultStepBorderType: BorderType.normal,
            unreachedStepBorderColor: Colors.blueGrey,
            unreachedStepIconColor: Colors.blueGrey,
            finishedStepBackgroundColor: Colors.white,
            finishedStepBorderColor: Colors.green[800],
            finishedStepBorderType: BorderType.normal,
            finishedStepIconColor: Colors.green[800],
            steps: List.generate(
              CartScreenFunctionality.listOfSteps.length,
              (index) =>
                  EasyStep(
                icon: Icon(
                  CartScreenFunctionality.listOfSteps[index].icon,
                ),
                customTitle:
                    Text(
                  CartScreenFunctionality.listOfSteps[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Axiforma',
                    fontSize: 12,
                    color: KColor9,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class CheckOutProceed extends StatelessWidget {
  int amount;
  CheckOutProceed({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Payment details',
          style: TextStyle(
            fontFamily: 'Axiforma',
            color: KColor9,
            fontSize: 18
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Net amount',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16
                ),
              ),
              Text('\$'+((amount/80).toInt()).toString(),
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Others charges',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16
                ),
              ),
              Text('0.02%',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery charges',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16
                ),
              ),
              Text('\$7',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bill amount',
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16
                ),
              ),
              Text('\$'+((amount/80)+(amount/80)*0.029 +7).toString(),
                style: TextStyle(
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          SizedBox(height:20),
          Text('On placing this you will be rewarded with 20 points in wallet',textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Axiforma',
                color: Colors.green,
                fontWeight: FontWeight.bold,fontSize: 15
            ),
          )
        ],
      ),
    );
  }
}

class ProductProceed extends StatelessWidget {
  var snapshot;
  var constraints;
  ProductProceed({required this.snapshot, required this.constraints});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!['User_Cart'].length,
              itemBuilder: (context, index) =>  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Transform.rotate(
                                angle: 0.5,
                                child: Image.network(snapshot.data!['User_Cart']
                                    [index]['Product_Banner'])),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!['User_Cart'][index]
                                        ['Product_Name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Axiforma'),
                                  ),
                                  Text(
                                    'x${snapshot.data!['User_Cart'][index]['Product_Quantity']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Axiforma'),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Rs.${snapshot.data!['User_Cart'][index]['Product_Quantity'] * snapshot.data!['User_Cart'][index]['Product_Price']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Axiforma'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  )
          ),

          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class CartData extends StatelessWidget {
  Map<String, dynamic> snapshot;
  int index;

  CartData({super.key, required this.index, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductScreen(
                    productScreenReq: ProductScreenRequired(
                        productName: snapshot['Product_Name'],
                        brandName: snapshot['Product_Brand'],
                        categoryType: snapshot['Product_Category']))));
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  flex: 7,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: Image.network(
                      snapshot['Product_Banner'],
                      loadingBuilder: (context, child, chunk) {
                        if (chunk != null)
                          return Center(
                            child: CircularProgressIndicator(
                              color: KColor9,
                              strokeWidth: 5,
                            ),
                          );
                        else
                          return child;
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot['Product_Name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Axiforma',
                                  fontSize: 16,
                                  color: KColor9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Color: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: 'Axiforma'),
                                    ),
                                    Text(
                                      '${snapshot['Product_Color']}.'
                                          .toLowerCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily: 'Axiforma'),
                                    )
                                  ],
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Size: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: 'Axiforma'),
                                    ),
                                    Text(
                                      '${snapshot['Product_Size']}'
                                          .toLowerCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'Axiforma',
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        CartScreenFunctionality()
                                            .increaseQuantityCart(
                                                val: IncreaseDecrease.decrease,
                                                productId:
                                                    snapshot['Product_ID']);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.remove,
                                            color: KColor9,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          '${snapshot['Product_Quantity']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        CartScreenFunctionality()
                                            .increaseQuantityCart(
                                                val: IncreaseDecrease.Increase,
                                                productId:
                                                    snapshot['Product_ID']);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.add,
                                            color: KColor9,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '₹' + '${snapshot['Product_Price']}.',
                                  style: TextStyle(
                                      color: KColor9,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Axiforma'),
                                )
                              ],
                            )
                          ],
                        ),
                        Positioned(
                            top: 20,
                            right: 10,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                CartScreenFunctionality().deleteCart(
                                    productId: snapshot['Product_ID']);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    IconlyLight.delete,
                                    size: 30,
                                  )),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
