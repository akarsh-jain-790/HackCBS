import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grass_hugs/common_widgets/theme_button.dart';
import 'package:grass_hugs/helper/colors_sys.dart';
import 'package:grass_hugs/helper/strings.dart';
import 'package:grass_hugs/screens/auth/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int currentIndex = 0;
  String text = Strings.nextText;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorSys.kblack,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: TextButton(
              onPressed: () {
                _storeOnboardInfo();
              },
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSys.kblack,
                    ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                  text =
                      currentIndex != 2 ? Strings.nextText : Strings.skipText;
                });
              },
              controller: _pageController,
              children: <Widget>[
                makePage(
                    image: 'assets/images/step_one.svg',
                    title: Strings.stepOneTitle,
                    content: Strings.stepOneContent),
                makePage(
                    image: 'assets/images/step_two.svg',
                    title: Strings.stepTwoTitle,
                    content: Strings.stepTwoContent),
                makePage(
                    image: 'assets/images/step_three.svg',
                    title: Strings.stepThreeTitle,
                    content: Strings.stepThreeContent),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makePage({image, title, content}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            image,
            height: 300,
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorSys.kblack),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorSys.kblack,
                  ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ThemeButton(
              name: text,
              onPressed: () {
                if (text == Strings.skipText) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                } else {
                  setState(() {
                    currentIndex += 1;
                    text =
                        currentIndex != 2 ? Strings.nextText : Strings.skipText;
                    _pageController.jumpToPage(currentIndex);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.kprimary, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
