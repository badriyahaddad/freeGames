import 'package:flutter/material.dart';

import '../../models/game_model.dart';

class GridTileWidget extends StatelessWidget {
  const GridTileWidget({super.key, required this.gameModel});
  final GameModel gameModel;
  @override
  Widget build(BuildContext context) {
    String type = gameModel.platform;
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: GridTile(
        header: Padding(
          padding: const EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
                backgroundColor: const Color.fromARGB(188, 0, 0, 0),
                child: type == "PC (Windows)"
                    ? const Icon(
                        Icons.computer,
                        color: Colors.purpleAccent,
                        size: 30,
                      )
                    : const Icon(
                        Icons.web,
                        color: Colors.purpleAccent,
                        size: 30,
                      )),
          ),
        ),
        footer: Container(
          width: size.width / 4,
          height: size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(97, 0, 0, 0),
                  Color.fromARGB(129, 0, 0, 0),
                  Color.fromARGB(158, 0, 0, 0),
                  Color.fromARGB(188, 0, 0, 0),
                  Color.fromARGB(232, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                gameModel.title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  color: Colors.white.withOpacity(0.07))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              gameModel.thumbnail,
              width: size.width / 8,
              height: size.width / 8,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: size.width / 8,
                  height: size.width / 8,
                  color: Colors.white,
                  child: const Center(
                    child: Icon(Icons.image),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
