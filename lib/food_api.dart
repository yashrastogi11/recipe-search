import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:your_cook/feed_api.dart';

//class FoodApi extends StatefulWidget {
//  String search;
//  FoodApi({Key key, @required this.search}) : super(key: key);
//  @override
//  _FoodApiState createState() => _FoodApiState();
//}
//
//class _FoodApiState extends State<FoodApi> {

class FoodApi extends StatelessWidget {
  String search;
  FoodApi({Key key, @required this.search}) : super(key: key);

  FeedData data;
  List<Recipes> recipes;

  Future<void> fetchRecipes() async {
    var res = await http.get(
        "https://www.food2fork.com/api/search?key=a1a83957f36aa0ff163794d58ad36af8&q=${search}");
    var decRes = jsonDecode(res.body);
    print(decRes);
    data = FeedData.fromJson(decRes);
    recipes = data.recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Suitable recipes for your ingredients",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 59, 48, 82),
      ),
      body: RefreshIndicator(
        onRefresh: fetchRecipes,
        child: FutureBuilder(
          future: fetchRecipes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Press button to start.");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: RefreshIndicator(
                    onRefresh: fetchRecipes,
                    child: FlareActor(
                      "images/Pizza Slice.flr",
                      animation: "Pizza Bounce",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) return errorData(snapshot);
                return recipeList();
            }
            return null;
          },
        ),
      ),
    );
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error: ${snapshot.error}"),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              fetchRecipes();
              //          setState(() {});
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }

  ListView recipeList() {
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) => Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.grey[100],
              elevation: 0.0,
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      if (await canLaunch(recipes[index].sourceUrl)) {
                        await launch(recipes[index].sourceUrl);
                      } else {
                        throw "Could not launch the recipe.";
                      }
                      //                if (!mounted) return;
                    },
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          recipes[index].imageUrl,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    child: Container(
                      padding: EdgeInsets.only(left: 7, right: 7),
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey,
                          backgroundBlendMode: BlendMode.multiply),
                      child: Text(
                        recipes[index].title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
