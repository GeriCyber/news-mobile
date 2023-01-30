import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _Article(article: news[index], index: index);
      }
    );
  }
}

class _Article extends StatelessWidget {
  final Article article;
  final int index;
  
  const _Article({required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopCard(article: article, index: index),
        _TitleCard(article: article),
        _ImageCard(article: article),
        _BodyCard(article: article),
        const _BottomFooter(),
        const SizedBox(height: 10),
        const Divider()
      ],
    );
  }
}

class _TopCard extends StatelessWidget {
  final Article article;
  final int index;
  
  const _TopCard({
    required this.article, required this.index,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1} ', style: const TextStyle(color: Colors.deepPurple)),
          Text('${article.source.name}. '),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article article;

  const _TitleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title, 
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article article;

  const _ImageCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: article.urlToImage != null ?
          FadeInImage(
            placeholder: const AssetImage('assets/img/giphy.gif'),
            image: NetworkImage(article.urlToImage!),
          ) : const Image(image: AssetImage('assets/img/no-image.png')),
        ),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article article;
  const _BodyCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((article.description != null) ? article.description as String : ''),
    );
  }
}

class _BottomFooter extends StatelessWidget {
  const _BottomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            fillColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: (){},
            child: const Icon(Icons.star_border_rounded),
          ),
          const SizedBox(width: 10),
          RawMaterialButton(
            fillColor: Colors.cyan.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: (){},
            child: const Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}