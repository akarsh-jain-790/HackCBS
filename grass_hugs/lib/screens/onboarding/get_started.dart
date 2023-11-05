import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grass_hugs/common_widgets/theme_button.dart';
import 'package:grass_hugs/helper/colors_sys.dart';
import 'package:grass_hugs/helper/strings.dart';
import 'package:grass_hugs/screens/onboarding/onboarding.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SvgPicture.asset(
              "assets/images/onboardingFg2.svg",
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        Strings.onboardingTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ThemeButton(
                        name: Strings.getStartedButtonText,
                        buttonColor: ColorSys.ktertiary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Onboarding()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: SvgPicture.asset(
                    "assets/images/onboardingFg.svg",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
