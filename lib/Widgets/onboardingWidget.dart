class OnboardingWidget{
   String image_location ;
   String caption ;
   OnboardingWidget({required this.image_location , required this.caption});
}

List<OnboardingWidget> onboardingPages = [
  OnboardingWidget(image_location: 'asset/gifs/gif1.gif' , caption:'Hi there..!\nWelcome to the Horsian family '),
  OnboardingWidget(image_location: 'asset/gifs/gif2.gif' , caption:'Get ready..\nAmazing deals and updates right here'),
  OnboardingWidget(image_location: 'asset/gifs/gif3.gif', caption:'Keep watching..\ninbox for exclusive members-only events, and discounts'),
];