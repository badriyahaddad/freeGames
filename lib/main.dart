import 'package:flutter/material.dart';
import 'package:freegames/providers/games_provider.dart';
import 'package:freegames/providers/theme_provider.dart';
import 'package:freegames/screens/home_screeen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Games()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(builder: (context, themeConsumer, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: themeConsumer.isDark
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 49, 49, 49),
                selectedItemColor: themeConsumer.isDark
                    ? const Color.fromARGB(255, 49, 49, 49)
                    : const Color.fromARGB(255, 255, 255, 255),
                unselectedItemColor: themeConsumer.isDark
                    ? Colors.grey.shade400
                    : Colors.grey.shade800,
              ),
              scaffoldBackgroundColor: themeConsumer.isDark
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 49, 49, 49),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                    color: themeConsumer.isDark ? Colors.white : Colors.black),
                color: themeConsumer.isDark ? Colors.black : Colors.white,
                titleTextStyle: TextStyle(
                    color: themeConsumer.isDark ? Colors.white : Colors.black),
              ),
              primarySwatch: Colors.blue,
            ),
            home: const HomeScreen(),
          );
        }));
  }
}
