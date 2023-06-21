import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewArticle {
  late String title;
  late String description;
  late String imageurl;
  bool isPressed;
  bool isFavourite;

  NewArticle(
      {required this.title,
      required this.description,
      required this.imageurl,
      this.isPressed = false,
      this.isFavourite = false});

  factory NewArticle.fromJson(Map<String, dynamic> json) {
    return NewArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageurl: json['urlToImage'] != null ? json['urlToImage'] : '',
    );
  }
}



Future<List<NewArticle>> fetchNewsArticles() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=YOURAPI'));

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    final List<dynamic> articlesJson = jsonBody['articles'];
    return articlesJson
        .map((articleJson) => NewArticle.fromJson(articleJson))
        .toList();
  } else {
    throw Exception('Failed to fetch news articles');
  }
}
