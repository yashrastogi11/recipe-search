import 'package:flutter/material.dart';
import 'package:your_cook/home_page.dart';
import 'package:your_cook/selected_photo.dart';


class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

List<String> photos = [
  "images/fries.jpg",
  "images/donut.jpg",
  "images/ice.jpg",
];

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation carouselAnimation;
  int photoIndex = 0;
  @override
  void initState() {
    super.initState();

    animController =
        new AnimationController(duration: Duration(seconds: 8), vsync: this);

    carouselAnimation =
        IntTween(begin: 0, end: photos.length - 1).animate(animController)
          ..addListener(() {
            setState(() {
              photoIndex = carouselAnimation.value;
            });
          });

    animController.repeat();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  Widget content(int photoIndex) {
    if (photoIndex == 0)
      return Text(
        "Welcome",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 59, 48, 82)),
      );
    else if (photoIndex == 1)
      return Text(
        "Welcome",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 59, 48, 82)),
      );
    else if (photoIndex == 2)
      return Text(
        "Welcome",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 59, 48, 82)),
      );
  }

  Widget content2(int photoIndex) {
    if (photoIndex == 0)
      return Text(
        "Lorem Ipsum is simple dummy \ntext of the padding and \ntypesetting industry.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
    else if (photoIndex == 1)
      return Text(
        "Lorem Ipsum is simple dummy \ntext of the padding and \ntypesetting industry.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
    else if (photoIndex == 2)
      return Text(
        "Lorem Ipsum is simple dummy \ntext of the padding and \ntypesetting industry.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          content(photoIndex),
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(photos[photoIndex]),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 50,
          ),
          content2(photoIndex),
          SizedBox(
            height: 30,
          ),
          SelectedPhoto(
            photoIndex: photoIndex,
            numberOfDots: 3,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonTheme(
            minWidth: 280,
            height: 60,
            child: RaisedButton(
              child: Text(
                "Hungry? Let's Cook",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 250, 249, 252),
                    fontWeight: FontWeight.bold),
              ),
              color: Color.fromARGB(255, 59, 48, 82),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
