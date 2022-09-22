import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  var grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
  var currentplayer = '❌';
  var win = '';

  void drawxo(i) {
    if (grid[i] == '-') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == '⭕' ? '❌' : '⭕';
      });
      winner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      win = '';
      grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
    });
  }

  bool checkmove(i, j, k, sign) {
    if (grid[i] == sign && grid[j] == sign && grid[k] == sign) {
      return true;
    }
    return false;
  }

  void winner(currentsign) {
    if (checkmove(0, 1, 2, currentsign) ||
        checkmove(3, 4, 5, currentsign) ||
        checkmove(6, 7, 8, currentsign) ||
        checkmove(0, 4, 8, currentsign) ||
        checkmove(2, 4, 6, currentsign) ||
        checkmove(0, 3, 6, currentsign) ||
        checkmove(1, 4, 7, currentsign) ||
        checkmove(2, 5, 8, currentsign)) {
      // print('$currentsign won');
      setState(() {
        win = currentsign;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Scaffold(
          appBar: AppBar(
              title: const Text(
            'Tic Tac Toe',
          )),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(22),
                // color: Colors.black,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: grid.length,
                  itemBuilder: (context, index) => Material(
                    color: Color.fromARGB(200, 0, 186, 167),
                    child: InkWell(
                      onTap: () => drawxo(index),
                      splashColor: const Color.fromARGB(201, 222, 222, 222),
                      child: Center(
                          child: Text(
                        grid[index],
                        style:
                            const TextStyle(fontSize: 50, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ),
              if (win != '')
                Text('$win won!', style: const TextStyle(fontSize: 35)),
              ElevatedButton.icon(
                onPressed: reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              )
            ],
          ),
        ));
  }
}
