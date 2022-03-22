import 'package:flutter/material.dart';
import 'package:minesweeper/utils/game_helper.dart';

import '../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MineSweeper game = MineSweeper();

  @override
  void initState() {
    super.initState();
    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('MineSweeper'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppColors.accentColor,
                        size: 34.0,
                      ),
                      const Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.timer,
                        color: AppColors.accentColor,
                        size: 34.0,
                      ),
                      const Text(
                        '10:32',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 500.0,
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MineSweeper.row,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: MineSweeper.cells,
              itemBuilder: (BuildContext context, index) {
                Color cellColor = game.gameMap[index].reveal ? AppColors.clickedCard : AppColors.lightPrimaryColor;
                return GestureDetector(
                  onTap: game.gameOver
                      ? null
                      : () {
                          game.onCellClicked(game.gameMap[index]);
                          setState(() {});
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                        child: Text(
                      game.gameMap[index].reveal ? '${game.gameMap[index].content}' : '',
                      style: TextStyle(
                        color: game.gameMap[index].reveal
                            ? game.gameMap[index].content == 'X'
                                ? Colors.red
                                : AppColors.lettersColors[game.gameMap[index].content]
                            : Colors.transparent,
                        fontSize: 20.0,
                      ),
                    )),
                  ),
                );
              },
            ),
          ),
          Text(
            game.gameOver ? 'You Lose' : '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 20.0),
          RawMaterialButton(
            onPressed: () {
              game.resetGame();
              game.gameOver = false;
              setState(() {});
            },
            fillColor: AppColors.lightPrimaryColor,
            elevation: 0,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 18.0),
            child: const Text(
              'Repeat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
