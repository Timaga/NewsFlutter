import 'package:shared_preferences/shared_preferences.dart';
import '../Api/Api_news.dart';
class Favorites {
  static const String _favoritesKey = 'favorites'; // ключ для хранения списка избранных статей

  // добавление статьи в список избранных
  static Future<void> addToFavorites(NewArticle article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? []; // получаем текущий список избранных
    favorites.add(article.title); // добавляем заголовок статьи в список
    await prefs.setStringList(_favoritesKey, favorites); // сохраняем обновленный список в SharedPreferences
  }

  // удаление статьи из списка избранных
  static Future<void> removeFromFavorites(NewArticle article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? []; // получаем текущий список избранных
    favorites.remove(article.title); // удаляем заголовок статьи из списка
    await prefs.setStringList(_favoritesKey, favorites); // сохраняем обновленный список в SharedPreferences
  }

  // получение списка избранных статей
  static Future<List<NewArticle>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? []; // получаем текущий список избранных
    // Получаем список всех статей
    List<NewArticle> articles = await fetchNewsArticles();
    // Фильтруем статьи и оставляем только те, которые есть в списке избранных
    List<NewArticle> favoriteArticles =
        articles.where((article) => favorites.contains(article.title)).toList();
    favoriteArticles.forEach((article) => article.isFavourite = true); // помечаем избранные статьи
    return favoriteArticles;
  }
}