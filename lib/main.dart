import 'package:flutter/material.dart';
import 'package:tictactoe/ui/theme/color.dart';
import 'package:tictactoe/game_controller.dart';

import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  int n = Game.n;
  Game update(Game game, int index){
    if (game.board![index ~/ n][index % n].value == " ") {
      game.board![index ~/ n][index % n].value = game.lastValue.value;
      game.turn.value++;
      game.gameOver.value = game.winnerCheck(index);

      if (game.gameOver.value) {
        game.result.value = "${game.lastValue.value} is the Winner";
      } else if (!game.gameOver.value && game.turn.value == (n * n)) {
        game.result.value = "It's a Draw!";
        game.gameOver.value = true;
      }
      if (game.lastValue.value == "X")
        game.lastValue.value = "O";
      else if (game.lastValue.value == "O")
        game.lastValue.value = "I";
      else
        game.lastValue.value = "X";
    }
    return game;
  }
  @override
  Widget build(BuildContext context) {
    Game game = Get.put(Game());
    game.initialize_board();
    double boardWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() =>
                Text(
                  "It's ${game.lastValue.value} turn".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 58,
                  ),
                )
            ),
            SizedBox(
              height: 20.0,
            ),
            //now we will make the game board
            //but first we will create a Game class that will contains all the data and method that we will need
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: n,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlenth, (index) {
                  debugPrint(index.toString());

                  return InkWell(
                    onTap: game.gameOver.value
                        ? null
                        : () {
                      game = update(game, index);
                    },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                          child: Obx(() =>
                              Text(
                                // game.test.value.toString(),
                                  game.board[index ~/ n][index % n].value,
                                  style: TextStyle(
                                  color: game.board[index ~/ n][index %
                                      n].value == "X"
                                      ? Colors.blue
                                      : (game.board[index ~/ n][index %
                                      n].value == "O"
                                      ? Colors.pink
                                      : Colors.greenAccent),
                                  fontSize: 64.0,
                                ),
                              ),
                          )
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Obx(() =>
                Text(
                  game.result.value,
                  style: TextStyle(color: Colors.white, fontSize: 50.0),
                )),
            ElevatedButton.icon(
              onPressed: () {
                { //erase the board
                  for(int i=0;i<n;i++)
                    for(int j=0;j<n;j++)
                      game.board[i][j].value = " ";
                  game.lastValue.value = "X";
                  game.gameOver.value = false;
                  game.turn.value = 0;
                  game.result.value = "";
                };
              },
              icon: Icon(Icons.replay),
              label: Text("Repeat the Game"),
            ),
          ],
        ));
  }
}
