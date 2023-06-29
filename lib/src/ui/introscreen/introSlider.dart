import 'package:conet/utils/constant.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';

import 'introVerify.dart';

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  List<ContentConfig> slides = [];

  Function? goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      const ContentConfig(
          title: "Welcome to the KONET App",
          description: "View, Manage, Download your Contacts on any device from anywhere at anytime hassle-free",
          pathImage: "assets/images/screen1.png"),
    );
    slides.add(
      const ContentConfig(
          title: "Welcome to the KONET App",
          description:
              "Secure yourself with the updated information of your Contacts and their businesses in real-time",
          pathImage: "assets/images/screen2.png"),
    );
    slides.add(
      const ContentConfig(
          title: "Welcome to the KONET App",
          description: "End - to - End Encryption. Privacy and Security is guaranteed.",
          pathImage: "assets/images/screen3.png"),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => IntroVerify()),
    );
  }

  void onTabChangeCompleted(index) {}

  Widget? renderNextBtn() {
    return const Icon(Icons.navigate_next, size: 25, color: AppColor.whiteColor);
  }

  Widget renderDoneBtn() {
    return const Icon(Icons.done, size: 25, color: AppColor.whiteColor);
  }

  Widget renderSkipBtn() {
    return const Icon(Icons.skip_next, size: 25, color: AppColor.whiteColor);
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      double widthImage;

      if (i == 0) {
        widthImage = displayWidth(context) * 0.9;
      } else if (i == 1) {
        widthImage = displayWidth(context) * 0.7;
      } else {
        widthImage = displayWidth(context) * 0.9;
      }

      ContentConfig currentSlide = slides[i];
      tabs.add(
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: i != 4
              ? Stack(
                  children: [
                    const SizedBox(height: 40),
                    Positioned(
                      right: 0,
                      width: MediaQuery.of(context).size.width,
                      top: MediaQuery.of(context).size.width * 0.2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => IntroVerify()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text("Skip",
                                style: Theme.of(context).textTheme.bodyText1!.apply(color: AppColor.whiteColor)),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            currentSlide.pathImage!,
                            fit: BoxFit.cover,
                            width: widthImage,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        Center(
                          child: Text(
                            "${currentSlide.title}",
                            style: Theme.of(context).textTheme.headline2!.apply(color: AppColor.whiteColor),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                            ),
                            child: Text(
                              "${currentSlide.description}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 15.0, color: AppColor.whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Stack(
                  children: [
                    const SizedBox(height: 40),
                    Positioned(
                      right: 0,
                      width: MediaQuery.of(context).size.width,
                      top: MediaQuery.of(context).size.width * 0.2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => IntroVerify()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text("Skip",
                                style: Theme.of(context).textTheme.bodyText1!.apply(color: AppColor.whiteColor)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width * 1.0,
                      top: MediaQuery.of(context).size.width * 0.4,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Lottie.asset(
                          'assets/json/introscreen.json',
                          height: MediaQuery.of(context).size.height * 0.6,
                          fit: BoxFit.fill,
                          repeat: false,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Text(
                          "${currentSlide.title}",
                          style: Theme.of(context).textTheme.headline2!.apply(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                          ),
                          child: Text(
                            "${currentSlide.description}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15.0, color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      );
    }
    return tabs;
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white30),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        width: screenWidth,
        height: screenHeight - 40,
        child: IntroSlider(
          renderSkipBtn: renderSkipBtn(),
          skipButtonStyle: myButtonStyle(),
          renderNextBtn: renderNextBtn(),
          onNextPress: onNextPress,
          nextButtonStyle: myButtonStyle(),
          renderDoneBtn: renderDoneBtn(),
          doneButtonStyle: myButtonStyle(),
          onDonePress: onDonePress,
          scrollPhysics: const BouncingScrollPhysics(),
          listCustomTabs: renderListCustomTabs(),
          onTabChangeCompleted: onTabChangeCompleted,
          refFuncGoToTab: (refFunc) {
            goToTab = refFunc;
          },
          // colorSkipBtn: Colors.white38,
          // highlightColorSkipBtn: AppColor.whiteColor,
          // colorDoneBtn: Colors.white38,
          // highlightColorDoneBtn: AppColor.whiteColor,
          // colorDot: AppColor.whiteColor,
          // sizeDot: 5.0,
          // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
          // backgroundColorAllSlides: AppColor.primaryColor,
          // shouldHideStatusBar: false,
        ),
      ),
    );
  }
}
