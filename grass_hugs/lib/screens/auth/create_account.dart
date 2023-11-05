import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grass_hugs/common_widgets/theme_button.dart';
import 'package:grass_hugs/common_widgets/theme_textfield.dart';
import 'package:grass_hugs/firebase/auth/controller/auth_controller.dart';

class CreateAccount extends ConsumerStatefulWidget {
  final String uid;
  const CreateAccount({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  late TextEditingController _fullName;
  late TextEditingController _email;
  late TextEditingController _about;
  late bool loginButtonState;

  @override
  void initState() {
    _fullName = TextEditingController();
    _email = TextEditingController();
    _about = TextEditingController();
    loginButtonState = false;

    super.initState();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _about.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Fill Your Profile"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/signin.svg",
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(
              height: 40,
            ),
            ThemeTextField(
              controllerName: _fullName,
              textFieldEvent: (value) {
                toggleButtton();
              },
              fieldName: "Full Name",
              icon: Icons.person_outlined,
            ),
            const SizedBox(
              height: 30,
            ),
            ThemeTextField(
              controllerName: _email,
              textFieldEvent: (value) {
                toggleButtton();
              },
              fieldName: "Email",
              icon: Icons.email,
            ),
            const SizedBox(
              height: 30,
            ),
            ThemeTextField(
              controllerName: _about,
              textFieldEvent: (value) {
                toggleButtton();
              },
              fieldName: "About",
              icon: Icons.info_outline,
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : ThemeButton(
                    name: "Sign Up",
                    onPressed: loginButtonState ? createAccount : null,
                  ),
          ],
        ),
      ),
    );
  }

  void createAccount() {
    Map<String, dynamic> userData = {
      "name": _fullName.text,
      "email": _email.text,
      "about": _about.text,
      "uid": widget.uid,
    };

    ref
        .read(authControllerProvider.notifier)
        .createAccountController(context, userData);
  }

  void toggleButtton() {
    if (_fullName.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _about.text.isNotEmpty) {
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
