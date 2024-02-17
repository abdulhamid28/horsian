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

class _BrandScreenState extends State<BrandScreen>
    with TickerProviderStateMixin {
  FocusNode searchNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  late AnimationController animationController;
  List<productContainerData> searchProduct = [];
  // bool isLiked = false;
  Display isBannerNumber = Display.allProduct;
  int numberOfProducts = 0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, upperBound: 0.3, duration: Duration(milliseconds: 100));
    super.initState();
  }

  callFunction() => animationController.forward(from: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    searchNode.dispose();
    animationController.dispose();
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
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Image.asset(
                                    (widget.brand == 'Brand_Nike')
                                        ? 'asset/images/nike_logo.png'
                                        : 'asset/images/adidas_logo_symbol.png',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Image.asset(
                                    (widget.brand == 'Brand_Nike')
                                        ? 'asset/images/nike name.png'
                                        : 'asset/images/adidas_logo_text.png',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    final cont =
                                        context.read<CustomProviderClass>();
                                    cont.changeScreen(4);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Stack(children: [
                                      Center(
                                        child: Container(
                                          color: Colors.white,
                                          child: Icon(
                                              bottomBarWidgetList[4].bottomBarIcon,
                                              size: 45,
                                              color: KColor5),
                                        ),
                                      ),
                                      Positioned(
                                        top: 30,
                                        left: 35,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(25),
                                          elevation: 5,
                                          child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: KColor9,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all()),
                                              child: Center(
                                                child: StreamBuilder(
                                                    stream: BaseScreenFunctionality
                                                        .getStreamOfCartScreenCount(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                          snapshot
                                                              .data!['User_Cart']
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11,
                                                          ),
                                                        );
                                                      } else
                                                        return CircularProgressIndicator(
                                                          color: KColor9,
                                                          strokeWidth: 5,
                                                        );
                                                    }),
                                              )),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Icon(IconlyBroken.search,
                                            color: KColor5),
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
                                            if (searchController.text.length >= 1)
                                              setState(() => isBannerNumber = Display.search);
                                            else
                                              setState(() => isBannerNumber = Display.allProduct);
                                                searchProduct = BrandScreenFunctionality.searchByName(
                                                    pattern: text,
                                                    list: value.allProducts);
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
                                      IconlyBold.filter_2,
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
                                            // color: Colors.white,
                                            border: (displayValue == isBannerNumber)
                                                ? Border(
                                                    bottom: BorderSide(
                                                        width: 5, color: KColor5))
                                                : null),
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
                                                  color:
                                                      Colors.black.withOpacity(0.3),
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
                      (isBannerNumber == Display.allProduct ||
                              isBannerNumber == Display.search)
                          ? // 999 all product  1000 search
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

  Padding SearchBuilder() {
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
                              onTap: () {},
                              splashColor: KColor9,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
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
                                    Positioned(
                                      right: 10,
                                      child: LikeButtonWidget(
                                        isLiked: false,  //todo : needed to check
                                      ),
                                    )
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
                        onTap: () {},
                        splashColor: KColor9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Positioned.fill(
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
                                                      '4.6',
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
                              Positioned(
                                right: 10,
                                child: LikeButtonWidget(
                                  isLiked: isLiked,
                                ),
                              )
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


//
//
// StreamBuilder(
// stream: BrandScreenFunctionality.fetchProductData(
// brandName: widget.brand,
// categoryType:
// (isBannerNumber!=999) ?
// BrandScreenFunctionality.listOfCategory[isBannerNumber].categoryType : ''
// ).asStream(),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// numberOfProducts = snapshot.data!.length;
// availableProduct = snapshot.data!;
// return Padding( padding: const EdgeInsets.only(left: 20, right: 20),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Results',
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontFamily: 'Axiforma',
// color: KColor9,
// fontSize: 18),
// ),
// Text(
// availableProduct.length.toString()+' ' + 'Products',
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontFamily: 'Axiforma',
// color: KColor9,
// fontSize: 12),
// ),
// ],
// ),
// GridView.builder(
// physics: NeverScrollableScrollPhysics(),
// itemCount: availableProduct.length,
// shrinkWrap: true,
// gridDelegate:
// SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// crossAxisSpacing: 15,
// mainAxisSpacing: 15,
// childAspectRatio: .67),
// itemBuilder: (context, index) => Material(
// borderRadius: BorderRadius.circular(20),
// color: Colors.white,
// elevation: 3,
// child: InkWell(
// borderRadius:
// BorderRadius.circular(20),
// onTap: () {},
// splashColor: KColor9,
// child: Container(
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(20)),
// child: Stack(
// children: [
// Positioned.fill(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .center,
// children: [
// Expanded(
// child: Image.network(
// availableProduct[index].imageBanner,
// fit: BoxFit.fill,
// frameBuilder: (context, child,val, d){
// if (val == null) return loadingShimmer(text: 'loading..');
// else return child;
// },
// loadingBuilder:
// (context, child,chunk) {
// if (chunk != null) return loadingShimmer(text: 'loading..');
// else return child;
// },
// errorBuilder:
// (context, object, stackTree) {
// return Padding(padding: const EdgeInsets.all(10.0),
// child: Shimmer(
// child:
// Container(
// height: 120,
// width: double
//     .maxFinite,
// decoration: BoxDecoration(
// color: Colors
//     .blueGrey
//     .shade100,
// borderRadius:
// BorderRadius.circular(
// 10)),
// child: Center(
// child: Text(
// 'unAvailable',
// style: TextStyle(
// fontFamily:
// 'Axiforma',
// color:
// Colors.white),
// ),
// ),
// ),
// ),
// );
// },
// ),
// ),
// Expanded(
// child: Column(
// children: [
// Text(
// availableProduct[
// index]
//     .productName +
// ' ' +
// 'Shoes',
// style: TextStyle(
// color:
// KColor9,
// fontFamily:
// 'Axiforma',
// fontWeight:
// FontWeight
//     .bold),
// ),
// Text(
// 'Rs.' +
// availableProduct[
// index]
//     .productPrice
//     .toString(),
// style: TextStyle(
// color:
// KColor9,
// fontFamily:
// 'Axiforma',
// fontWeight:
// FontWeight
//     .bold),
// ),
// Padding(
// padding:
// const EdgeInsets
//     .only(
// top: 5),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceEvenly,
// children: [
// Row(
// children: [
// Icon(
// IconlyBold
//     .star,
// color:
// Color(0xffFDCC0D)),
// Text(
// '4.6',
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize:
// 14),
// )
// ],
// ),
// Text(
// '+' +
// availableProduct[index]
//     .colorCount
//     .toString() +
// ' ' +
// 'Colors',
// style:
// TextStyle(
// color:
// KColor8,
// //fontFamily: 'Axiforma',
// // fontWeight: FontWeight.bold
// ),
// ),
// ],
// ),
// )
// ],
// ),
// ),
// ],
// ),
// ),
// Positioned(
// right: 10,
// child: LikeButtonWidget(
// isLiked: isLiked,
// ),
// )
// ],
// ),
// ),
// ),
// )),
// ],
// ),
// );
// }

// })
// :
// SearchBuilder(),
