import 'package:horsian/Resources/exports.dart';

class ShimmerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation : 1,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: double.maxFinite,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer(
                colorOpacity: 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.maxFinite- 30,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black.withOpacity(0.2)
                    ),
                  ),
                ),
              ),
              Shimmer(
                colorOpacity: 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width:100,
                    height: 20,
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
                    width: double.maxFinite- 30,
                    height: 20,
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
                    width: double.maxFinite- 30,
                    height: 20,
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
                    width:100,
                    height: 20,
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
      ),
    );
  }
}
