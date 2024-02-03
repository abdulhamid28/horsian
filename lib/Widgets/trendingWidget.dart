import 'package:horsian/Resources/exports.dart';
import 'package:horsian/Widgets/likeButton.dart';
class TrendingWidget extends StatefulWidget {
  Size size ;
  TrendingWidget({super.key,  required this.size});

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
              onTap: (){},
              splashColor: KColor9,
              child: Container(
                width: widget.size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Image.asset('asset/images/nike shoe 1.png'),
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
                                      Text('Nike Spectre ',
                                        style:
                                        GoogleFonts.goblinOne(),
                                      ),
                                      Row(
                                        children: [
                                          Text('4.6', style:
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
                                      ),)

                                    ],
                                  ))
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
      Positioned(top: 0, left: 0, child: TrendingTag(rank: 1))
    ]);
  }
  Widget TrendingTag({required int rank}) {
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
                        'asset/images/nike_logo.png',
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
