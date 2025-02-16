import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacking_game/button.dart';
import 'package:stacking_game/pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 160; // Número total de cuadrados en la cuadrícula
  List<int> piece =
      []; // Lista que contiene la posición actual de la pieza en movimiento
  var direction = "left"; // Dirección inicial del movimiento de la pieza
  List<int> landed = [
    100000
  ]; // Lista que contiene las posiciones de las piezas apiladas
  int level = 0; // Nivel actual del juego

  // Función para iniciar el juego
  void startGame() {
    piece = [
      numberOfSquares - 3 - level * 10,
      numberOfSquares - 2 - level * 10,
      numberOfSquares - 1 - level * 10
    ];
    Timer.periodic(Duration(milliseconds: 550), (timer) {
      if (checkWinner()) {
        _showDialog();
        timer.cancel();
      }
      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.last % 10 == 9) {
        direction = "left";
      }
      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });
    });
  }

  // Función para verificar si el jugador ha ganado
  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  // Función para mostrar un diálogo cuando el jugador gana
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("GANASTE!"),
          );
        });
  }

  // Función para apilar la pieza actual
  void stack() {
    level++;
    setState(() {
      for (int i = 0; i < piece.length; i++) {
        landed.add(piece[i]);
      }

      if (level < 4) {
        piece = [
          numberOfSquares - 3 - level * 10,
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10
        ];
      } else if (level >= 4 && level < 8) {
        piece = [
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10
        ];
      } else if (level >= 8) {
        piece = [numberOfSquares - 1 - level * 10];
      }
      checkStack();
    });
  }

  // Función para verificar y limpiar las piezas apiladas incorrectamente
  void checkStack() {
    setState(() {
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numberOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numberOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
    });
  }

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
                  if (piece.contains(index)) {
                    return MyPixel(color: Colors.white);
                  } else if (landed.contains(index)) {
                    return MyPixel(color: Colors.white);
                  } else {
                    return MyPixel(color: Colors.black);
                  }
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    function: startGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  MyButton(
                    function: stack,
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
