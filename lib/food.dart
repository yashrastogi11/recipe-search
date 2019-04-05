import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:your_cook/feed_api.dart';
import 'package:your_cook/food_api.dart';

class Foods extends StatefulWidget {
  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  FeedData data;
  List<Recipes> recipes;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Use available ingredients for perfect dish",
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 59, 48, 82),
      ),
      body: enterText(),
    );
  }

  Widget enterText() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: "Search",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodApi(search: searchController.text)));

                      //             fetchRecipes();
                    },
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter all the available ingredients",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/chef1.png",
                  fit: BoxFit.contain,
                )),
          ],
        ),
      ],
    );
  }

  searchFood() {
    return FutureBuilder(
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
            //            if (snapshot.hasError) return errorData(snapshot);
            return recipeList();
        }
        return null;
      },
    );
  }

  Future<void> fetchRecipes() async {
    var res = await http.get(
        "https://www.food2fork.com/api/search?key=2499801e64c2830ad342667fa806395c&q=${searchController}");
    var decRes = jsonDecode(res.body);
    print(decRes);
    data = FeedData.fromJson(decRes);
    recipes = data.recipes;
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
                      if (!mounted) return;
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
