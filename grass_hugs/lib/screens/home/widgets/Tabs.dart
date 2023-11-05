import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TabsMenu extends StatefulWidget {
  const TabsMenu({super.key});

  @override
  State<TabsMenu> createState() => _TabsMenuState();
}

class _TabsMenuState extends State<TabsMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('All Requests'),
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Pending')),
                  Tab(child: Text('Completed')),
                  Tab(child: Text('Cancel')),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[Text(""), Text(""), Text("")],
        ),
      )),
    );
  }
}
