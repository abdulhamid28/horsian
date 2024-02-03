import 'package:horsian/Resources/exports.dart';

class ClipperClass extends CustomClipper<Path>{
  double height ;
  ClipperClass({required this.height });

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0,height);
    path.lineTo(height,0);
    return path ;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

   return true;
  }

}