import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grass_hugs/common_widgets/theme_button.dart';
import 'package:grass_hugs/firebase/auth/controller/auth_controller.dart';
import 'package:grass_hugs/helper/colors_sys.dart';
import 'package:grass_hugs/helper/strings.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class OTPVerification extends ConsumerStatefulWidget {
  String phoneNumber;
  String verificationId;
  int? resendToken;
  OTPVerification(
      {super.key,
      required this.phoneNumber,
      required this.verificationId,
      required this.resendToken});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OTPVerificationState();
}

class _OTPVerificationState extends ConsumerState<OTPVerification> {
  late final TextEditingController _verificationPin;
  late Timer timer;
  int secondsRemaining = 30;
  bool enableResend = false;

  @override
  void initState() {
    _verificationPin = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _verificationPin.dispose();
    timer.cancel();
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
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/icons/signin.svg",
                height: MediaQuery.of(context).size.height / 3,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                Strings.codeText +
                    widget.phoneNumber.replaceRange(3, 9, "*****"),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Pinput(
                controller: _verificationPin,
                length: 6,
                showCursor: true,
                pinAnimationType: PinAnimationType.slide,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  decoration: BoxDecoration(
                      color: ColorSys.ksecondary,
                      borderRadius: BorderRadius.circular(12)),
                  height: 50,
                  width: 50,
                ),
                onCompleted: (pin) {
                  ref
                      .read(authControllerProvider.notifier)
                      .verifyPhoneController(context, widget.verificationId,
                          _verificationPin.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !enableResend
                      ? Text(
                          Strings.resendCodeInText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CreateAccount())
                      // );
                    },
                    child: Text(
                      !enableResend
                          ? secondsRemaining.toString()
                          : Strings.resendCodeText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : ThemeButton(
                        buttonColor: ColorSys.ktertiary,
                        name: Strings.verifyText,
                        onPressed: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .verifyPhoneController(context,
                                  widget.verificationId, _verificationPin.text);
                        },
                      ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
