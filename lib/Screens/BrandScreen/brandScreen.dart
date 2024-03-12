import 'package:horsian/Resources/exports.dart';

enum Display {
  search,
  allProduct,
  categoryRunning,
  categorySneaker,
  categoryWalking
}

class BrandScreen extends StatefulWidget {
  String brand;
  BrandScreen({required this.brand});
  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> with TickerProviderStateMixin {

  FocusNode searchNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  //late VideoPlayerController videoPlayerController ;
  late AnimationController animationController;

  List<ProductContainerData> searchProduct = [];
  Display isBannerNumber = Display.allProduct; //0


  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, upperBound: 0.3, duration: Duration(milliseconds: 100));
    super.initState();
    // videoPlayerController = VideoPlayerController.networkUrl(
    //     Uri.parse(
    //         (widget.brand=='Brand_Adidas') ? HomeScreenFunctionality.popularBrandNameList[1].brandVideoLink:
    //         HomeScreenFunctionality.popularBrandNameList[0].brandVideoLink  ))
    //   ..initialize().then((value) {setState(() {});});
    // videoPlayerController.play();
    // videoPlayerController.setVolume(0);
  }

  callFunction() => animationController.forward(from: 0);

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();
    animationController.dispose();
    //videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CustomProviderClass>(
      builder: (context,value , child) {
        return Column(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 60),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: (searchNode.hasFocus) ? Border.all(color:  KColor9 , width: 2) : Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Icon(IconlyLight.search,
                                            color: KColor9),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          focusNode: searchNode,
                                          controller: searchController,
                                          decoration: InputDecoration(
                                              hintText: 'Search here..!',
                                              hintStyle: TextStyle(
                                                  height: 1.2,
                                                  fontFamily: 'Axiforma'),
                                              border: InputBorder.none),
                                          onChanged: (text) {
                                            if (searchController.text.length >= 1) setState(() => isBannerNumber = Display.search);
                                            else setState(() => isBannerNumber = Display.allProduct);
                                                searchProduct = BrandScreenFunctionality.searchByName(pattern: text, list: value.allProducts);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 57,
                                    decoration: BoxDecoration(
                                        borderRadius: (BorderRadius.circular(20)),
                                        color: KColor9),
                                    child: Icon(
                                      IconlyBold.filter,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric( horizontal:  0.0),
                      //   child: ClipRRect(
                      //    // borderRadius: BorderRadius.circular(20),
                      //     child: GestureDetector(
                      //       onTap: (){videoPlayerController.initialize();
                      //         videoPlayerController.play();
                      //         },
                      //       child: SizedBox(
                      //          height: 500,
                      //          width: double.maxFinite,
                      //         child: (!videoPlayerController.value.isInitialized) ?
                      //           Image.asset(
                      //               (widget.brand== 'Brand_Nike')?
                      //               'asset/images/nike video image.png': 'asset/images/adidas video image.png',
                      //               fit: BoxFit.fill) :
                      //           VideoPlayer(videoPlayerController),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Text(
                          'Category',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Axiforma',
                              color: KColor9,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20.0),
                        child: SizedBox(
                          height: 125,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              Display displayValue = (index == 0)
                                  ? Display.categoryRunning
                                  : (index == 1)
                                      ? Display.categorySneaker
                                      : Display.categoryWalking;
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, bottom: 5),
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    splashColor: KColor9,
                                    onTap: () {
                                      callFunction();
                                      setState(() {
                                        searchController.text = '';
                                        searchProduct = BrandScreenFunctionality.searchByCategory(
                                            category: (displayValue== Display.categoryRunning) ? 'FootWear_Running' :
                                            (displayValue==Display.categorySneaker)? 'FootWear_Sneaker' :'FootWear_Walking',
                                            list: value.allProducts);
                                        if (isBannerNumber != displayValue) isBannerNumber = displayValue;
                                        else isBannerNumber = Display.allProduct;
                                      });
                                    },
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      builder: (context, child) => Container(
                                        height: 120,
                                        width: size.width - 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: (displayValue == isBannerNumber)
                                                ? Border(
                                                    bottom: BorderSide(
                                                        width: 5, color: KColor5,
                                                    ),
                                            )
                                                : null
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Transform.rotate(
                                                angle: (isBannerNumber == displayValue)
                                                    ? animationController.value
                                                    : 0,
                                                child: Image.asset(
                                                    BrandScreenFunctionality
                                                        .listOfCategory[index]
                                                        .imagePath,
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                BrandScreenFunctionality
                                                    .listOfCategory[index].title,
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.anton(
                                                  fontSize: 60,
                                                  color: Colors.black.withOpacity(0.3),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      (isBannerNumber == Display.allProduct || isBannerNumber == Display.search) ? // 999 all product  1000 search
                          (isBannerNumber == Display.allProduct)
                              ? StreamerContainer(brandName: widget.brand)
                              : SearchBuilder()
                          : SearchBuilder()
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget SearchBuilder() {
    return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search Results',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Axiforma',
                                color: KColor9,
                                fontSize: 18),
                          ),
                          Text(
                            searchProduct.length.toString()+' ' + 'Products',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Axiforma',
                                color: KColor9,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: searchProduct.length,
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: .67),
                          itemBuilder: (context, index) => Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            elevation: 3,
                            child: InkWell(
                              borderRadius:
                              BorderRadius.circular(20),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductScreen(
                                    productScreenReq: ProductScreenRequired(
                                        productName: searchProduct[index].productName,
                                        categoryType: searchProduct[index].categoryType,
                                        brandName: searchProduct[index].brandName),
                                ),
                                ),
                                );
                              },
                              splashColor: KColor9,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        searchProduct[index].imageBanner,
                                        fit: BoxFit.fill,
                                        frameBuilder: (context, child,val, d){
                                          if (val == null) return ShimmerLoader(text: 'loading..');
                                          else return child;
                                        },
                                        loadingBuilder: (context, child,chunk) {
                                          if (chunk != null) return ShimmerLoader(text: 'loading..');
                                          else return child;
                                        },
                                        errorBuilder: (context, object, stackTree) {
                                          return Padding(padding: const EdgeInsets.all(10.0),
                                            child: Shimmer(
                                              child:
                                              Container(
                                                height: 120,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey.shade100,
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text('unAvailable',
                                                    style: TextStyle(
                                                        fontFamily: 'Axiforma',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            searchProduct[index].productName + ' ' + 'Shoes',
                                            style: TextStyle(
                                                color: KColor9,
                                                fontFamily: 'Axiforma',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Rs.' + searchProduct[index].productPrice.toString(),
                                            style: TextStyle(
                                                color: KColor9,
                                                fontFamily: 'Axiforma',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        IconlyBold.star,
                                                        color: Color(0xffFDCC0D)),
                                                    Text(
                                                      '4.6',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  '+' + searchProduct[index].colorCount.toString() + ' ' + 'colors',
                                                  style:
                                                  TextStyle(
                                                    color: KColor8,
                                                    //fontFamily: 'Axiforma',
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                );
  }
}

class StreamerContainer extends StatefulWidget {
  String brandName;
  StreamerContainer({required this.brandName });
  @override
  State<StreamerContainer> createState() => _StreamerContainerState();
}

class _StreamerContainerState extends State<StreamerContainer> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: FutureBuilder(
          future: BrandScreenFunctionality.fetchAllProductData(brandName: widget.brandName,),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              final cont = context.read<CustomProviderClass>();
              cont.setProduct(snapshot.data!);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Results',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Axiforma',
                            color: KColor9,
                            fontSize: 18),
                      ),
                      Text(
                        snapshot.data!.length.toString() + ' ' + 'Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Axiforma',
                            color: KColor9,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: .67),
                    itemBuilder: (context, index) => Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      elevation: 3,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          ProductScreenRequired productScreenRequired = ProductScreenRequired(
                              productName: snapshot.data![index].productName,
                              categoryType: snapshot.data![index].categoryType,
                              brandName: snapshot.data![index].brandName);
                          Navigator.push(context, MaterialPageRoute(builder: (context )=>ProductScreen(
                            productScreenReq: productScreenRequired,
                          )));
                        },
                        splashColor: KColor9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  snapshot.data![index].imageBanner,
                                  fit: BoxFit.fill,
                                  frameBuilder: (context, child, val, d) {
                                    if (val == null)
                                      return ShimmerLoader(
                                          text: 'loading..');
                                    else
                                      return child;
                                  },
                                  loadingBuilder:
                                      (context, child, chunk) {
                                    if (chunk != null)
                                      return ShimmerLoader(
                                          text: 'loading..');
                                    else
                                      return child;
                                  },
                                  errorBuilder:
                                      (context, object, stackTree) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Shimmer(
                                        child: Container(
                                          height: 120,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.blueGrey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'unAvailable',
                                              style: TextStyle(
                                                  fontFamily: 'Axiforma',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data![index].productName +
                                          ' ' +
                                          'Shoes',
                                      style: TextStyle(
                                          color: KColor9,
                                          fontFamily: 'Axiforma',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Rs.' +
                                          snapshot
                                              .data![index].productPrice
                                              .toString(),
                                      style: TextStyle(
                                          color: KColor9,
                                          fontFamily: 'Axiforma',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(IconlyBold.star,
                                                  color:
                                                      Color(0xffFDCC0D)),
                                              Text(
                                                '${snapshot.data![index].productRating}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                          Text(
                                            '+' + snapshot.data![index].colorCount.toString() + ' ' + 'colors',
                                            style: TextStyle(
                                              color: KColor8,
                                              //fontFamily: 'Axiforma',
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );}
            else return GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: .6),
                itemBuilder: (context, index) => Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        ShimmerLoader(text: 'Loading..',),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Shimmer(
                            child: Container(
                              height: 20,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Shimmer(
                            child: Container(
                              height: 20,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
      ),
    );
  }
}

