class FeedData {
  int count;
  List<Recipes> recipes;

  FeedData({this.count, this.recipes});

  FeedData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['recipes'] != null) {
      recipes = new List<Recipes>();
      json['recipes'].forEach((v) {
        recipes.add(new Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.recipes != null) {
      data['recipes'] = this.recipes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipes {
  String title;
  String sourceUrl;
  String recipeId;
  String imageUrl;

  Recipes(
      {
      this.title,
      this.sourceUrl,
      this.recipeId,
      this.imageUrl,});

  Recipes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sourceUrl = json['source_url'];
    recipeId = json['recipe_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['source_url'] = this.sourceUrl;
    data['recipe_id'] = this.recipeId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}