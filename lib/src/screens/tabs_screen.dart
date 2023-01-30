import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:news_app/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

import '../services/news_services.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavigationModel(),
      child: const Scaffold(
        body: _Screens(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context, listen: false);
        
    return BottomNavigationBar(
      currentIndex: navigationModel.currentScreen,
      onTap: (value) {
        navigationModel.currentScreen = value;
        newsService.selectedCategory = 'Business';
      }, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'For you'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public_rounded),
          label: 'Headers'
        ),
      ]
    );
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Screen(),
        Tab2Screen()
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentScreen = 0;
  PageController _pageController = PageController();
  
  int get currentScreen => _currentScreen;

  set currentScreen(int screenIndex) {
    _currentScreen = screenIndex;
    _pageController.animateToPage(
      screenIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}