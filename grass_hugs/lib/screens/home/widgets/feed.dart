import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grass_hugs/screens/home/widgets/post_item.dart';

class FeedUI extends StatelessWidget {
  const FeedUI({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List> dataList = getPostData();

    return FutureBuilder<List<dynamic>>(
        future: dataList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    const Text(
                      "Daily Chanllenge: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return PostItem(
                            img: snapshot.data![index]["image"],
                            name: snapshot.data![index]['name'],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<List> getPostData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;

    late List data = [];

    await db.collection("Posts").get().then((event) {
      for (var doc in event.docs) {
        data.add(doc.data());
      }
    });

    return data;
  }
}
