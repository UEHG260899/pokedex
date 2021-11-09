import 'package:flutter/material.dart';

import 'package:pokedex/src/api_class.dart';

class PokeView extends StatefulWidget {
  PokeView({Key? key}) : super(key: key);

  @override
  _PokeViewState createState() => _PokeViewState();
}

class _PokeViewState extends State<PokeView> {
  late Future<PokemonInfo> pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = traerPokemon();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<PokemonInfo>(
        future: pokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: size.width * 0.7,
                        child: Stack(
                          //alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: size.width * 0.6,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            ),
                            FadeInImage(
                              placeholder: AssetImage("assets/pokeball.jpg"),
                              image: NetworkImage(
                                  "${PokemonInfo.imgUrl}/${snapshot.data!.id}.png"),
                              height: size.width * 0.6,
                              width: size.width * 0.6,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0 / 2.5),
                            child: Text(
                              'Nombre: ${snapshot.data!.name}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(
                            'Tipos: ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Container(
                            height: 50.0,
                            child: ListView.builder(
                              itemCount: snapshot.data!.types.length,
                              padding: const EdgeInsets.all(10.0),
                              itemBuilder: (context, position){
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 15.0,
                                        )
                                      ),
                                      TextSpan(
                                        text: "${snapshot.data!.types[position].type.name}",
                                        style: TextStyle(fontSize: 16.0, color: Colors.black)
                                      )
                                    ]
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.0,)
                        ],
                      )
                    ],
                  ),
                ),

              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        });
  }
}
