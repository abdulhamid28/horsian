import 'package:horsian/Functionality/productScreenFunctions.dart';
import 'package:horsian/Resources/exports.dart';

class ProductScreen extends StatefulWidget {
  ProductContainerData productContainerData;
  ProductScreen({super.key , required this.productContainerData });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentAngle = 0;
  int currentColor = 0;
  int amountPay = 0;
  int currentSize=0;
  int quantity=1;

  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppBar appBar = AppBar(
      elevation: 0,
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            IconlyLight.arrow_left_2,
            size: 30,
            color: KColor9,
          )),
      title: Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          IconlyBold.bag,
          size: 30,
          color: KColor9,
        ),
      ),
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: ProductScreenFunctionality.getProducts(
              brandName: widget.productContainerData.brandName,
              categoryType: widget.productContainerData.categoryType,
              productName: widget.productContainerData.productName
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              amountPay= snapshot.data!.docs[currentColor]['Product_Price'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            width: size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Column(
                                        children: List.generate(snapshot.data!.docs[currentColor]['Product_Angle'].length,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    pageController.animateToPage(currentAngle, curve: Curves.easeIn,
                                                            duration: Duration(milliseconds: 400));
                                                    setState(() {
                                                      currentAngle = index;
                                                    });
                                                  },
                                                  child: AngleContainer(
                                                    isShimmer: false,
                                                    imgUrl: snapshot.data!.docs[currentColor]['Product_Angle'][index],
                                                    isFocused:
                                                        (index == currentAngle) ? true : false,
                                                  ),
                                                ),
                                        ).toList()),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: PageView.builder(
                                    onPageChanged: (page) {
                                      setState(() {
                                        currentAngle = page;
                                      });
                                    },
                                    controller: pageController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs[currentColor]['Product_Angle'].length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:Image.network(
                                        snapshot.data!.docs[currentColor]['Product_Angle'][currentAngle],
                                        fit: BoxFit.fill,
                                        loadingBuilder: (context, child , chunk){
                                          if(chunk!=null) return Center(child: CircularProgressIndicator(color: KColor9, strokeWidth: 5));
                                          else return child;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,0),
                            child: Container(
                              width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex:4,
                                      child: Text(widget.productContainerData.productName,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Axiforma'
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Icon(IconlyBold.star, color: Color(0xffFDCC0D)),
                                          Text(' ${widget.productContainerData.productRating}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                              color: KColor9
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: Container(
                                color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 0),
                                child: Text('Instock',
                                  style: TextStyle(
                                      fontFamily: 'Axiforma',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,20,20,0),
                            child: Container(
                              height: 90,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Text('Colors:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontFamily: 'Axiforma'
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        color: Colors.white,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context , colorIndex){
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                                                    child: Material(
                                                      elevation: 5,
                                                      color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20),
                                                      child: InkWell(
                                                        onTap: (){
                                                           setState(() {
                                                             currentAngle=0;
                                                             currentColor= colorIndex;
                                                           });
                                                        },
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: (colorIndex==currentColor)? Border.all(): null
                                                          ),
                                                          child: Image.network(
                                                            snapshot.data!.docs[colorIndex]['Product_Angle'][0],
                                                            loadingBuilder: (context , child , chunk){
                                                              if(chunk!=null)return Center(child: CircularProgressIndicator(color: KColor9, strokeWidth: 5));
                                                              else return child;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,20,20,0),
                            child: Container(
                              height: 110,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Stack(
                                      children: [
                                        Text('Size:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Axiforma'
                                          ),
                                        ),
                                        Positioned(
                                            right: 10,
                                            top: -1,
                                            child: GestureDetector(
                                                onTap: (){
                                                  showDialog(barrierDismissible: true,
                                                      context: context,
                                                      builder:(context)=> Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: GestureDetector(
                                                            onTap: ()=> Navigator.of(context).pop(),
                                                            child: Image.asset('asset/images/sizechart.png')),
                                                      ));
                                                },
                                                child: Icon(IconlyBold.info_circle,color: Colors.grey,size: 20,)))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        color: Colors.white,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.docs[currentColor]['Product_Size'].length,
                                            itemBuilder: (context , sizeIndex){
                                              int availableSizeCount = snapshot.data!.docs[currentColor]['Product_Size'][sizeIndex];
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                                                    child: Material(
                                                      elevation: (availableSizeCount!=0) ? 5 : 0,
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          if(availableSizeCount>0)
                                                          setState(() {
                                                            currentSize= sizeIndex+6;
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              border: (sizeIndex+6==currentSize)? Border.all(width: 1): null
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '${sizeIndex+6}',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily: 'Axiforma',
                                                                color: (sizeIndex+6==currentSize) ? KColor9: Colors.grey.shade400
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    (availableSizeCount<=2 && availableSizeCount!=0 )?
                                                    'Only ${availableSizeCount} Left':'',
                                                      style: TextStyle(
                                                          height: 1,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10, fontFamily: 'Axiforma',
                                                          color: Colors.red[800]),
                                                  )
                                                ],
                                              );
                                            }
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Axiforma'
                                    ),
                                ),
                                Row(
                                  children: [
                                    Material(
                                      elevation: 5,
                                      borderRadius : BorderRadius.circular(10),
                                      color: KColor9,
                                      child: GestureDetector(
                                        onTap: (){
                                          if(quantity>1) setState(()=>quantity--);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.remove,color: Colors.white,size: 30,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 50,
                                        child: Center(child: Text('${quantity}'))),
                                    Material(
                                    elevation: 5,
                                    borderRadius : BorderRadius.circular(10),
                                    color: KColor9,
                                    child: GestureDetector(
                                      onTap: (){
                                        if(quantity<10) setState(() => quantity++);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.add,color: Colors.white,size: 30,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text('About the product',
                                  style: TextStyle(
                                    fontFamily: 'Axiforma',
                                    fontWeight: FontWeight.bold,
                                    color: KColor9
                                  ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(widget.productContainerData.productDescription1,textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: KColor9,fontFamily: 'Axiforma',height: 1,fontWeight: FontWeight.bold, fontSize: 15
                                              ),
                                          ),
                                      ),
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(widget.productContainerData.productDescriptionImage,
                                            loadingBuilder: (context , child , chunk){
                                              if(chunk!=null) return Center(child: CircularProgressIndicator());
                                              else return child;
                                            },
                                            )),
                                      ))
                                    ],
                                  ),
                                  Text(widget.productContainerData.productDescription2, textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontFamily: 'Axiforma',

                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text('Things you need to Know',
                                    style: TextStyle(
                                        fontFamily: 'Axiforma',
                                        fontWeight: FontWeight.bold,
                                        color: KColor9
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  List.generate( 
                                        ProductScreenFunctionality.availableServiceList.length,
                                            (index) => Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Material(
                                                    elevation: 5,
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
                                                    child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      height: 65,
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      child: Image.asset(ProductScreenFunctionality.availableServiceList[index].imagePath),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 65,
                                                  child: Text(ProductScreenFunctionality.availableServiceList[index].title,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize :10,fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20) , topRight:  Radius.circular(20)),
                      color: Colors.white,
                      child: Container(
                        height: 80,
                        width: size.width,
                        decoration: BoxDecoration(
                             borderRadius: BorderRadius.only(topLeft:Radius.circular(20) , topRight:  Radius.circular(20))
                            ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Center(
                                    child: Text('Pay' + '  ' + '₹${amountPay*quantity}.',
                                      style: TextStyle(
                                        fontFamily: 'Axiforma',
                                        fontWeight: FontWeight.bold,
                                        color: KColor9,
                                        fontSize: 20
                                      ),
                                    )
                                )),
                            Expanded(flex: 3, child: Container(
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight:  Radius.circular(20)),
                                  color: KColor9
                              ),
                              child: Icon(IconlyBold.buy, size: 40,color: Colors.white,),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else
              return Column(
                children: [
                  Shimmer(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Column(
                                  children: List.generate(
                                      4,
                                      (index) => AngleContainer(
                                            isShimmer: true,
                                            imgUrl: '',
                                            isFocused: (index == currentAngle)
                                                ? true
                                                : false,
                                          )).toList()),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 20, top: 10, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(20)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ShimmerWidget(),
                  )
                ],
              );
          }),
    );
  }
}

class AngleContainer extends StatelessWidget {
  bool isShimmer;
  bool isFocused;

  String imgUrl;

  AngleContainer(
      {super.key,
      required this.isFocused,
      required this.isShimmer,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: (isShimmer) ? Colors.grey.shade100 : Colors.white,
        child: Container(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: (!isShimmer && isFocused)
                  ? Border.all(color: Colors.black38, width: 1)
                  : null),
          child: (isShimmer)
              ? Container()
              : Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child , chunk){
                    if(chunk!=null) return Center(child: CircularProgressIndicator(color: KColor9, strokeWidth: 5));
                    else return child;

                  },
                ),
        ),
      ),
    );
  }
}
