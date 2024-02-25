import 'package:horsian/Resources/exports.dart';
import 'package:horsian/Widgets/likeButton.dart';
class TrendingWidget extends StatefulWidget {
  Size size ;
  ProductContainerData productContainerData ;
  TrendingWidget({super.key , required this.size, required this.productContainerData,});
  @override
  State<TrendingWidget> createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  bool isLiked =false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        child: Padding(
          padding:
          const EdgeInsets.only(right: 10.0, bottom: 5),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ProductScreen(productContainerData: widget.productContainerData,),));
              },
              splashColor: KColor9,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: widget.size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: Image.network(widget.productContainerData.imageBanner,
                            loadingBuilder: (context, child,chunk) {
                              if (chunk != null) return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 6),
                              );
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
                                      color: Colors.grey.shade100,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('unAvailable',
                                        style: TextStyle(
                                            fontFamily: 'Axiforma',
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,8,8),
                        child: Container(
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  right: 3,
                                  child:LikeButtonWidget(isLiked: isLiked,) ),
                              Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.productContainerData.productName,
                                        style:
                                        GoogleFonts.goblinOne(),
                                      ),
                                      Row(
                                        children: [
                                          Text('${widget.productContainerData.productRating}', style:
                                          GoogleFonts.goblinOne(
                                              fontSize:10
                                          ),),
                                          Icon(IconlyBold.star, color: Color(0xffFDCC0D))
                                        ],
                                      ),
                                      Text('More Details', style: GoogleFonts.goblinOne(
                                          fontSize: 10,
                                          decoration: TextDecoration.underline,
                                          color: Colors.grey
                                      ),
                                      )
                                    ]
                                  ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(top: 0, left: 0, child: TrendingTag(brand: widget.productContainerData.brandName))
    ]);
  }
  Widget TrendingTag({required String brand}) {
    return ClipPath(
      clipper: ClipperClass(height: 70),
      child: Shimmer(
        child: Material(
          elevation: 3,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.red[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
            ),
            child: Transform.rotate(
              angle: -pi / 4,
              origin: Offset(-20, 12),
              child: Center(
                child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        (brand == 'Brand_Adidas')? 'asset/images/adidas_logo.png':'asset/images/nike_logo.png' ,
                        color: Colors.white,
                      ),
                    )),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
