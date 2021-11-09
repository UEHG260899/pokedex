import 'package:flutter/material.dart';

import 'package:pokedex/src/poke_vw.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Pokedex',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            elevation: 0,
          ),
          body: PokeView(),
        ));
  }
}
