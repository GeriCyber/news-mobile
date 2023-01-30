import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_mode.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _baseURL = 'https://newsapi.org/v2';
const _apiKEY = '37ecbe18339d4b2ab6c12621e4de8573';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categories = [
    Category(Icons.business_center_rounded, 'Business'),
    Category(Icons.tv_rounded, 'Entertainment'),
    Category(Icons.ads_click_rounded, 'General'),
    Category(Icons.health_and_safety_rounded, 'Health'),
    Category(Icons.science_rounded, 'Science'),
    Category(Icons.sports_baseball_rounded, 'Sports'),
    Category(Icons.phone_android, 'Technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};
  String _selectedCategory = 'Business';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    getArticlesByCategory(category);
    notifyListeners();
  }

  List<Article> get getArticlesFromSelectedCategory => categoryArticles[selectedCategory]!;

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
    getArticlesFromSelectedCategory;
    print(getArticlesFromSelectedCategory);
  }

  getTopHeadlines() async {
    const url = '$_baseURL/top-headlines?apiKey=$_apiKEY&country=us';
    final response = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromMap(json.decode(response.body));
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if(categoryArticles[category] != null && categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url = '$_baseURL/top-headlines?apiKey=$_apiKEY&country=us&category=$category';
    final response = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromMap(json.decode(response.body));
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}