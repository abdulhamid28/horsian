import 'package:horsian/Resources/exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  int currentPage =0;
  bool isDonePressed= false;

  @override
  void dispose() {
     super.dispose();
     pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;     // Size of screen
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          PageBuilder(size),
          NavigatorPageBuilder(context)
        ],
      )
    );
  }

  Expanded NavigatorPageBuilder(BuildContext context) {
    return Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
               // color: Colors.red
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()=> pageController.jumpToPage(2),
                    child: Text('Skip' , style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Axiforma',
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3,
                            (index) => GestureDetector(
                              onTap: ()=> pageController.jumpToPage(index),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 20, width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 2 , color: KColor9),
                                    color: currentPage == index ? KColor9 : Colors.white
                                  ),
                                ),
                              ),
                            )
                    ),
                  ),
                  (currentPage!=2) ?GestureDetector(
                    onTap: ()=> pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn),
                    child:  Text('Next' ,
                      style: TextStyle(
                        fontSize: 16, fontFamily: 'Axiforma', fontWeight: FontWeight.bold
                     ),
                    ),
                  ) : GestureDetector(
                      onTap: (){
                        setState(()=> isDonePressed = true);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        setState(()=> isDonePressed = false);
                      },
                    child : (isDonePressed)?  CircularProgressIndicator(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: KColor9,strokeWidth: 7,
                    ) :   Text('Done' , style: TextStyle(
                        fontSize: 16, fontFamily: 'Axiforma', fontWeight: FontWeight.bold
                       ),
                    ),
                  ),
                ],
              ),
            ),
        );
  }

  Expanded PageBuilder(Size size) {
    return Expanded(
          flex: 18,
          child:  Stack(
                  children: [
                    Positioned(
                      top: -65, right: -90,
                      child: Container(
                        height: size.width/1.5, width: size.width/1.5,
                        decoration: BoxDecoration(
                            color: KColor9.withOpacity(.8),
                            borderRadius: BorderRadius.circular(360)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 115.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (val)=> setState(()=> currentPage = val),
                          itemCount: 3,
                          itemBuilder: (context,index)=> Padding(
                               padding:(index!=2) ?  const EdgeInsets.all(15.0) : const EdgeInsets.all(40.0),
                               child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Image.asset(onboardingPages[index].image_location),
                                   FadeIn(
                                     curve: Curves.ease,
                                     duration: Duration(seconds: 2),
                                     child: Text(onboardingPages[index].caption,
                                       textAlign: TextAlign.center,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Axiforma',
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ) ,
                        ),
                        ),
                    ),
                    Positioned(
                      left: -30, bottom: 10,
                      child: Container(
                        height: 60, width: 60,
                        decoration: BoxDecoration(
                            color: KColor9.withOpacity(.7),
                            borderRadius: BorderRadius.circular(360)
                        ),
                      ),
                    ),
                  ]
          )
        );
  }
}


