import 'package:horsian/Resources/exports.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late CarouselController carouselController;
  late ScrollController scrollController;

  double top = -100;
  double offset = 0;

  void initState() {
    carouselController = CarouselController();
    scrollController = ScrollController();
    // periodicCallFunction();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            CarouselSlider(
              carouselController: carouselController,
              items: HomeScreenFunctionality.generateCarouselWidget(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                autoPlay: false,
                viewportFraction: 0.9,
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Trending',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Axiforma',
                        color: KColor9,
                        fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                      height: 22,width: 22,
                      child: Image.asset('asset/images/fire.png'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: SizedBox(
                height: 180,
                child: FutureBuilder(
                  future: HomeScreenFunctionality.getTrendingProducts(),
                  builder: ( context , snapshot){
                    if(snapshot.hasData)return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: TrendingWidget(
                              size: size,productContainerData: snapshot.data![index],
                            ),
                          );
                        });
                    else return TrendingWidgetShimmer();
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Popular Brands',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Axiforma',
                    color: KColor9,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 150,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: 1.3),
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          final  providerValue = context.read<CustomProviderClass>();
                          providerValue.changeScreen(index+5);
                        },
                        splashColor: KColor9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(40, 35, 40, 35),
                            child: Image.asset(
                              HomeScreenFunctionality.popularBrandNameList[index].brandLogo,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}






// Container(
//   color: Colors.green,
//   height: (350+top)<0 ? 0 : 350+top,
//   width: double.maxFinite,
//   child: Padding(
//     padding: const EdgeInsets.fromLTRB(20.0,0,20,0),
//     child: Stack(
//       children: [
//         Positioned(
//           bottom: 0,
//           top: top,left: 0,right: 0,
//           child: Image.asset('asset/images/Banner.jpg', fit: BoxFit.fitWidth,)),]
//     ),
//   ),
// ),
// Container(
//   height: 600,
//   width: double.maxFinite,
//   color: Colors.red,
// )

// SizedBox(
//   height: size.height * 1 / 4,
//   child: PageView.builder(
//       clipBehavior: Clip.none,
//       controller: pageController,
//       scrollDirection: Axis.horizontal,
//       itemCount: HomeScreenFunctionality.carouselImageList.length,
//       itemBuilder: (context, index) {
//         return AnimatedBuilder(
//             animation: pageController,
//             builder: (context, child) {
//               double pageOffset = 0;
//               if (pageController.position.haveDimensions) {
//                 pageOffset = pageController.page!- index;
//               }
//               return Container(
//                 margin: EdgeInsets.only(left: 8, right: 8),
//                 clipBehavior: Clip.none,
//                 height: 300,
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25)),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(25),
//                   child: Image.asset(
//                     HomeScreenFunctionality
//                         .carouselImageList[index],
//                     fit: BoxFit.contain,
//                     alignment: Alignment(pageOffset, 0),
//                   ),
//                 ),
//               );
//             });
//       }),
// ),

// scrollController.addListener(() {
//   if(offset>scrollController.offset) {
//     changePositionDownward();
//   }else{
//     changePositionUpward();
//   }
//   offset= scrollController.offset;
//
//   print(scrollController.offset);
// });

// void changePositionUpward(){
//   setState(() {
//     if(top<0)
//     top= top+0.5;
//   });
// }
// void changePositionDownward(){
//   setState(() {
//     top= top-0.5;
//   });
// }

// void periodicCallFunction() {
//   Timer.periodic(Duration(seconds: 5), (timer) {
//     setState(() {
//       if (pageController.page ==
//           HomeScreenFunctionality.carouselImageList.length - 1)
//         pageController.jumpToPage(0);
//       else
//         pageController.nextPage(
//             duration: Duration(seconds: 1), curve: Curves.easeIn);
//     });
//   });
// }