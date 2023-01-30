import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tabs_screen.dart';
import 'package:news_app/src/services/news_services.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => NewsService())
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        home: const TabsScreen(),
        theme: appTheme,
      ),
    );
  }
}