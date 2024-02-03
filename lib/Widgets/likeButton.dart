import 'package:horsian/Resources/exports.dart';

class LikeButtonWidget extends StatefulWidget {
  bool isLiked;
   LikeButtonWidget({super.key , required this.isLiked});

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLiked = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        setState(() {
          isLiked = (isLiked)? false: true ;
        });

      },
      //color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 40,width: 40 ,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Icon(
          (isLiked)? IconlyBold.heart:IconlyLight.heart,
          size: 35,
          color: Colors.red[700],
        ),
      ),
    );
  }
}
