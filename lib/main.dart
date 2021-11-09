import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokedex/src/api_class.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<PokemonInfo> pokemon;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    pokemon = traerPokemon();
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        pokemon = traerPokemon();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex por Uriel Hernandez',
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
        ),
        body: Center(
          child: FutureBuilder<PokemonInfo>(
            future: pokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      Card(
                          elevation: 10.0,
                          child: Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${PokemonInfo.imgUrl}/${snapshot.data!.id}.png"),
                                    radius: 100.0,
                                    backgroundColor: Colors.red,
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  Text('Nombre: ${snapshot.data!.name}'),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  Text('Tipos:'),
                                  Container(
                                    height: 50.0,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.types.length,
                                      padding: const EdgeInsets.all(10.0),
                                      itemBuilder: (context, position) {
                                        return Text(
                                            "${snapshot.data!.types[position].type.name}",
                                            textAlign: TextAlign.center,);
                                      },
                                    ),
                                  )
                                ],
                              ))),
                      TextButton(onPressed: () {}, child: Text('Obtener otro'))
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}
