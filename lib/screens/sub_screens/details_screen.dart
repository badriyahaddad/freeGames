import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/games_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/static_widget/shimmer_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.detailsModelID});
  final int detailsModelID;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    Provider.of<Games>(context, listen: false)
        .getDetailsGames(widget.detailsModelID);
    super.initState();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Consumer<Games>(builder: (context, detailsConsumer, _) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                Provider.of<Games>(context, listen: false);
              },
              child: Center(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: size.width,
                        height: size.height / 3,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              detailsConsumer.detailsModel!.screenshots.length,
                          itemBuilder: (context, currentPage) {
                            return detailsConsumer.isLoading
                                ? ShimmerWidget(
                                    baseColor: themeListener.isDark
                                        ? const Color.fromARGB(
                                            255, 202, 202, 202)
                                        : const Color.fromARGB(255, 61, 61, 61),
                                    height: size.width / 4,
                                    hilighColor: themeListener.isDark
                                        ? const Color.fromARGB(
                                            255, 236, 236, 236)
                                        : const Color.fromARGB(255, 92, 92, 92),
                                    radius: 8,
                                    width: size.width / 4,
                                  )
                                : Image.network(detailsConsumer.detailsModel!
                                    .screenshots[currentPage].image);
                          },
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                        ),
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: currentPage,
                      count: detailsConsumer.detailsModel!.screenshots.length,
                      effect: WormEffect(
                        dotColor: themeListener.isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade500,
                        activeDotColor: themeListener.isDark
                            ? Colors.purple.shade300
                            : Colors.amber.shade300,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            detailsConsumer.detailsModel!.title,
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: size.height / 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            detailsConsumer.detailsModel!.description,
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          )),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Developer: ${detailsConsumer.detailsModel!.developer}",
                            style: TextStyle(
                                color: themeListener.isDark
                                    ? const Color.fromARGB(255, 92, 91, 91)
                                    : const Color.fromARGB(255, 156, 156, 156),
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          )),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
