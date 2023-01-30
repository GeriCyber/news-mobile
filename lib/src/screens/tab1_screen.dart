import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:provider/provider.dart';
import '../widgets/news_list.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({super.key});

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context).headlines;
    return Scaffold(
      body: (newsService.isEmpty) 
      ? const Center(child: CircularProgressIndicator()) 
      : NewsList(news: newsService),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}