import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grass_hugs/common_widgets/theme_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String firebase_error = "";
  late TextEditingController _cropNameController;
  late TextEditingController _amountController;
  late TextEditingController _ageOfHarvestController;

  @override
  void initState() {
    _cropNameController = TextEditingController();
    _amountController = TextEditingController();
    _ageOfHarvestController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cropNameController.dispose();
    _amountController.dispose();
    _ageOfHarvestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Post Snap",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'assets/icons/signin.svg',
                width: 250,
                height: 250,
              ),
              Row(
                children: [
                  Visibility(
                    // ignore: sort_child_properties_last
                    child: Text(
                      firebase_error,
                      // ignore: prefer_const_constructors
                      style: TextStyle(color: Colors.red),
                    ),
                    visible: firebase_error == "" ? false : true,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      // CreateRequest();
                    },
                    child: const Text("Post")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
