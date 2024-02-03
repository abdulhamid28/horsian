import 'package:horsian/Resources/exports.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomProviderClass>(
        builder: (context, value, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (bottomBarWidgetList[value.getScreen()].screenName !=
                            Screen.profileScreen &&
                        (bottomBarWidgetList[value.getScreen()].screenName !=
                            Screen.brandScreen))
                    ? HeaderCard(controller: value)
                    : const SizedBox(),
                DisplayScreen(controller: value),
                BottomBar(controller: value),
              ],
            ))));
  }

  Expanded HeaderCard({required CustomProviderClass controller}) {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text:
                        '${bottomBarWidgetList[controller.getScreen()].lightText}\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Axiforma',
                        color: Colors.black45,
                        fontSize: 25),
                  ),
                  TextSpan(
                    text: bottomBarWidgetList[controller.getScreen()].boldText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Axiforma',
                        color: KColor9,
                        fontSize: 25),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
                onTap: () {
                  final cont = context.read<CustomProviderClass>();
                  cont.changeScreen(4);
                },
                child: Stack(children: [
                  Center(
                    child: Container(
                        color: Colors.white,
                        child: Icon(bottomBarWidgetList[4].bottomBarIcon,
                            size: 45, color: KColor5)),
                  ),
                  Positioned(
                    top: 30,
                    left: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(25),
                      elevation: 5,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: KColor9,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: StreamBuilder(
                              stream: BaseScreenFunctionality
                                  .getStreamOfCartScreenCount(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!['User_Cart'].length
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      //  fontFamily: 'Axiforma'
                                    ),
                                  );
                                } else
                                  return CircularProgressIndicator(
                                    color: KColor9,
                                    strokeWidth: 5,
                                  );
                                //   Text('0' , style: TextStyle(
                                // color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                // fontSize: 11,
                                // //  fontFamily: 'Axiforma'
                                // ),);
                              }),
                        ),
                      ),
                    ),
                  )
                ])),
          )
        ],
      ),
    );
  }

  Widget DisplayScreen({required CustomProviderClass controller}) {
    return Expanded(
        flex: (bottomBarWidgetList[controller.getScreen()].screenName !=
                    Screen.profileScreen &&
                (bottomBarWidgetList[controller.getScreen()].screenName !=
                    Screen.brandScreen))
            ? 26
            : 30,
        child: bottomBarWidgetList[controller.getScreen()].screen);
  }

  Widget BottomBar({required CustomProviderClass controller}) {
    double width = 30;
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: KColor9.withOpacity(1)),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final cont = context.read<CustomProviderClass>();
                        cont.changeScreen(index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bottomBarWidgetList[index].bottomBarIcon,
                                color: (index == controller.getScreen())
                                    ? Colors.white
                                    : Colors.white60,
                                size: 30,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                height: 3,
                                width: width,
                                decoration: BoxDecoration(
                                    color: (index == controller.getScreen())
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
