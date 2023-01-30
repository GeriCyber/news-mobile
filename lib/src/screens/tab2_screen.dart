import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_mode.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoriesScrollList(),
            Expanded(
              child: NewsList(news: newsService.getArticlesFromSelectedCategory)
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(category: categories[index]),
                const SizedBox(height: 5),
                Text(categories[index].name)
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({
    required this.category,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.8)
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name) 
          ? Colors.deepPurple 
          : Colors.black54,
        ),
      ),
    );
  }
}