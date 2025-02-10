import 'package:flutter/material.dart';
import 'package:stacking_game/button.dart';
import 'package:stacking_game/pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 160;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int index) {
                  return MyPixel(color: Colors.black);
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  MyButton(
                    child: Text(
                      "S T O P",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
