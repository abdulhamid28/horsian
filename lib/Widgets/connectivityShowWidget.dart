import 'package:horsian/Resources/exports.dart';

class ConnectivityShow extends StatelessWidget {
  bool first = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InternetStatus>(
      stream: InternetConnection().onStatusChange,
      builder: (context,snapshot){
         if(first == false) {
            if (snapshot.data == InternetStatus) return SizedBox(child: Text(' '),);
            else if (snapshot.data == InternetStatus.disconnected) return Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('No Network Access',
                     style: TextStyle(fontSize: 16,
                         fontFamily: 'Axiforma',
                         color: Colors.red,
                         fontWeight: FontWeight.bold)),
                 SizedBox(width: 5,),
                 Icon(IconlyBold.shield_fail, color: Colors.red, size: 30,)
               ],
             );
            else return SizedBox(child: Text(' '),);
         }
         else{
             first = false ;
             return SizedBox(
             child: FutureBuilder(
                 future: SignupScreenFunctionality.customConnectivityCheck(),
                 builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                        return (snapshot.data) ?SizedBox( child: Text(' '),) :
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('No Network Access',
                               style: TextStyle(fontSize: 16,
                                   fontFamily: 'Axiforma',
                                   color: Colors.red,
                                   fontWeight: FontWeight.bold)),
                            SizedBox(width: 5,),
                            Icon(IconlyBold.shield_fail, color: Colors.red, size: 30,)
                        ],
                   ) ;
                 }else{
                   return SizedBox(child: Text(' '),);
                 }
               },
             ),
           );
         }
      },);
  }
}




