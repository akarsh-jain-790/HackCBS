import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grass_hugs/common_widgets/theme_button.dart';
import 'package:grass_hugs/firebase/auth/controller/auth_controller.dart';
import 'package:grass_hugs/helper/colors_sys.dart';
import 'package:grass_hugs/helper/strings.dart';
import 'package:grass_hugs/screens/auth/widget/phone_number_field.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late TextEditingController _countryCodeController;
  late TextEditingController _phoneNumberController;
  late bool loginButtonState;

  @override
  void initState() {
    _countryCodeController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _countryCodeController.text = "+91";
    loginButtonState = false;
    super.initState();
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "assets/icons/signin.svg",
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              Strings.signInTitleText,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            PhoneNumberField(
              (value) {
                _countryCodeController.text = value;
                toggleButtton();
              },
              (value) {
                _phoneNumberController.text = value;
                toggleButtton();
              },
              _countryCodeController,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : ThemeButton(
                      name: "Sign in",
                      buttonColor: ColorSys.ktertiary,
                      onPressed: loginButtonState ? _signInWithPhone : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithPhone() {
    ref.read(authControllerProvider.notifier).signInWithPhoneController(
        context, _countryCodeController.text, _phoneNumberController.text);
  }

  void toggleButtton() {
    if (_phoneNumberController.text.isNotEmpty &&
        _countryCodeController.text.isNotEmpty &&
        _phoneNumberController.text.length == 10) {
      setState(() {
        loginButtonState = true;
      });
    } else {
      setState(() {
        loginButtonState = false;
      });
    }
  }
}
