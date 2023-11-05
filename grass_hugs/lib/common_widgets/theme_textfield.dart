import 'package:flutter/material.dart';
import 'package:grass_hugs/helper/colors_sys.dart';

class ThemeTextField extends StatelessWidget {
  const ThemeTextField({
    super.key,
    this.controllerName,
    required this.fieldName,
    this.textFieldEvent,
    required this.icon,
    this.fieldColor,
    this.border = false,
    this.isEnabled = true,
    this.passwordField = false,
  });

  final TextEditingController? controllerName;
  final void Function(dynamic)? textFieldEvent;
  final String fieldName;
  final bool passwordField;
  final Color? fieldColor;
  final IconData icon;
  final bool? border;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorSys.kgrey, width: border == true ? 0.8 : 0.0),
        borderRadius: BorderRadius.circular(20),
        color: fieldColor ?? ColorSys.kwhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: controllerName,
              onChanged: textFieldEvent,
              keyboardType: TextInputType.text,
              obscureText: passwordField,
              enableSuggestions: !passwordField,
              autocorrect: !passwordField,
              enabled: isEnabled,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: fieldName,
                  icon: Icon(
                    icon,
                    color: ColorSys.kprimary,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
