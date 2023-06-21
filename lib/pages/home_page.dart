import 'package:flutter/material.dart';
import 'package:flutter_example_2/models/favourite.dart';
import '../Api/Api_news.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<NewArticle>>? _newsArticles;

  @override
  void initState() {
    super.initState();
    _newsArticles = fetchNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blueGrey,
            title: Text('My News'),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                   Navigator.pushNamed(context, '/favourite_page');
                },
              ),
            ],
          ),
          FutureBuilder<List<NewArticle>>(
            future: _newsArticles,
            builder: (BuildContext context,
                AsyncSnapshot<List<NewArticle>> snapshot) {
              if (snapshot.hasData) {
                List<NewArticle> articles = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      NewArticle article = articles[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ExpansionTile(
                            title: Text(article.title,
                                style: TextStyle(color: Colors.white)),
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (article.isPressed == true) {
                                      article.isPressed = false;
                                      Favorites.removeFromFavorites(article);
                                    } else {
                                      article.isPressed = true;
                                      Favorites.addToFavorites(article);
                                    }
                                  });
                                },
                                child: Icon(Icons.favorite_border,
                                    color: article.isPressed == true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              SizedBox(height: 10),
                              Image.network(article.imageurl),
                              SizedBox(height: 10),
                              Text(article.description,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: articles.length,
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
