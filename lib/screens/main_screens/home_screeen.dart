import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freegames/models/game_moel.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/games_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/static_widget/grid_tile_widget.dart';
import '../widgets/static_widget/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  String? platform;

  @override
  void initState() {
    Provider.of<Games>(context, listen: false).getGames(platform);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<ThemeProvider>(context, listen: true);
    final themeFunction = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Free Games",
          style: TextStyle(
            fontSize: 30,
            color: themeListener.isDark
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Switch(
              onChanged: (bool value) {
                setState(() {
                  themeFunction.switchMode();
                });
              },
              value: themeListener.isDark,
              activeColor: const Color.fromARGB(255, 233, 180, 5),
              activeTrackColor: const Color.fromARGB(255, 253, 220, 127),
              inactiveTrackColor: const Color.fromARGB(255, 187, 114, 255),
              inactiveThumbColor: const Color.fromARGB(255, 122, 32, 138),
            ),
          ),
        ],
      ),
      body: Consumer<Games>(builder: (context, gamesConsumer, _) {
        return Center(
          child: RefreshIndicator(
            onRefresh: () async {
              Provider.of<Games>(context, listen: false).getGames(platform);
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !gamesConsumer.isFailed
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Popular",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: themeListener.isDark
                                              ? Colors.blue
                                              : Colors.amber,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.height / 3.5,
                                  ),
                                  Align(
                                    alignment: const Alignment(8, 0),
                                    child: Text(
                                      gamesConsumer.gameList.length.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: themeListener.isDark
                                              ? const Color.fromARGB(
                                                  255, 0, 0, 0)
                                              : const Color.fromARGB(
                                                  255, 255, 255, 255),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return gamesConsumer.isLoading
                                      ? ShimmerWidget(
                                          baseColor: const Color.fromARGB(
                                              213, 49, 49, 49),
                                          height: size.width / 4,
                                          hilighColor: const Color.fromARGB(
                                              255, 65, 65, 65),
                                          radius: 8,
                                          width: size.width / 4,
                                        )
                                      : GridTileWidget(
                                          gameModel:
                                              gamesConsumer.gameList[index],
                                        );
                                },
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: size.height * 1.01,
                          child: const Text("Failed"))
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentIndex == 0
                ? platform = null
                : currentIndex == 1
                    ? platform = "pc"
                    : platform = "browser";
          });
          Provider.of<Games>(context, listen: false).getGames(platform);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "All"),
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: "PC"),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Browser"),
        ],
      ),
    );
  }
}
