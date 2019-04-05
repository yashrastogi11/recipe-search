
import 'package:flutter/material.dart';

class Ingredient extends StatefulWidget {
  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Get all the ingredients of your dish",
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 59, 48, 82),
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                labelText: "Search",
              ),
//              onFieldSubmitted: fetchRecipes(),
            ),
          ],
        ),
      ),
    );
  }

//  fetchRecipes() async {
//    var res = await http.get(
//        "https://www.food2fork.com/api/search?key=7ee66faf70cc5b4c17a05fc12799f2c6");
//    var decRes = jsonDecode(res.body);
//    data = FeedData.fromJson(decRes);
//    recipes = data.recipes;
//  }



  
}
