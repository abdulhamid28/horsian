import 'package:horsian/Resources/exports.dart';

class TrendingWidgetShimmer extends StatelessWidget {
  const TrendingWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:20),
      child: Material(
        elevation:3,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                      child: Shimmer(
                        colorOpacity: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer(
                          colorOpacity: 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blueGrey.shade100
                              ),
                            ),
                          ),
                        ),
                        Shimmer(
                          colorOpacity: 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 16,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blueGrey.shade100
                              ),
                            ),
                          ),
                        ),
                        Shimmer(
                          colorOpacity: 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blueGrey.shade100
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


