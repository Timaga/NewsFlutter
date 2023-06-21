import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/Api_news.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  Future<List<NewArticle>>? _newsArticles;
  List<NewArticle>? _favoriteArticles;

  @override
  void initState() {
    super.initState();
    _loadFavoriteArticles();
  }

  // Функция для загрузки списка избранных статей
  void _loadFavoriteArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    List<NewArticle> articles = await fetchNewsArticles();
    List<NewArticle> favoriteArticles =
        articles.where((article) => favorites.contains(article.title)).toList();
    setState(() {
      _favoriteArticles = favoriteArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blueGrey,
            title: Text('My Favourite News'),
            actions: [],
          ),
          (_favoriteArticles == null)
              ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      NewArticle article = _favoriteArticles![index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.description),
                        trailing: Icon(Icons.favorite, color: Colors.red),
                      );
                    },
                    childCount: _favoriteArticles!.length,
                  ),
                ),
        ],
      ),
    );
  }
}
