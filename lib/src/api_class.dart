import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class PokemonInfo {
  String name;
  int id;
  double weight;
  double height;
  List<TypeElement> types;
  //URL del repositorio de imagenes
  static final String imgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";

  PokemonInfo({
    required this.name,
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
  });

  factory PokemonInfo.fromJson(Map<String, dynamic> json){
    return PokemonInfo(
      name: json['name'],
      id: json['id'],
      weight: json['weight'] / 10,
      height: json['height'] / 10,
      types: List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
    );
  }
}

/*
 * 
 * Tipados
 * Se generaron usando quicktype.io a partir de la respuesta de la API 
 * 
 */

class TypeElement {
    TypeElement({
       required this.slot,
       required this.type,
    });

    int slot;
    TypeType type;

    factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        slot: json["slot"],
        type: TypeType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}

class TypeType {
    TypeType({
        required this.name,
    });

    String name;

    factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

/*Fin tipados*/

//Petición de la API
Future<PokemonInfo> traerPokemon() async {
  var rng = new Random();
  int numero = rng.nextInt(200);
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon/${numero}';
  final response = await http.get(Uri.parse(baseUrl));

  if(response.statusCode == 200){
    return PokemonInfo.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('No se pudo extraer la información del pokemon');
  }
}