import 'package:camera/camera.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:grass_hugs/screens/home/widgets/camera.dart';
import 'package:grass_hugs/screens/home/widgets/feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Widget> _pages = <Widget>[
    FeedUI(),
    Center(child: Text("Maps Tab")),
    Center(child: Text("Settings Tab")),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.directions),
            title: Text('Maps'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.settings_rounded),
            title: Text('Settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        label: const Row(
          children: [Text('Hugs')],
        ),
        onPressed: () async {
          await availableCameras().then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
        },
      ),
    );
  }
}
