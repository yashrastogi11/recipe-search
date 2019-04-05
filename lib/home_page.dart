import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:your_cook/feed.dart';
import 'package:your_cook/food.dart';
import 'package:your_cook/ingredients.dart';



    


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  final List<Widget> _children = [
    Foods(),
    Feed(),
    Ingredient(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you really want to exit the app?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          textColor: Colors.white,
          barBackgroundColor: Color.fromARGB(255, 59, 48, 82),
          circleColor: Color.fromARGB(255, 255, 179, 1),
          inactiveIconColor: Colors.white,
          initialSelection: 1,
          tabs: [
            TabData(iconData: Icons.fastfood, title: "Know Your Food", ),
            TabData(iconData: Icons.message, title: "Feed"),
            TabData(iconData: Icons.fastfood, title: "Know Your Ingredients"),
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
        body: _children[currentPage],
      ),
    );
  }
}

