import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grass_hugs/helper/colors_sys.dart';

// ignore: must_be_immutable
class PhoneNumberField extends StatelessWidget {
  final TextEditingController _countryCodeController;
  final void Function(dynamic)? _countryCodeEvent;
  final void Function(dynamic)? _phoneEvent;
  const PhoneNumberField(
      this._countryCodeEvent, this._phoneEvent, this._countryCodeController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: ColorSys.kwhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 40,
              child: TextField(
                controller: _countryCodeController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (value) => _countryCodeEvent!(value),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const Text(
              "|",
              style: TextStyle(fontSize: 32, color: Colors.grey),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                onChanged: (value) => _phoneEvent!(value),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Phone Number",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
