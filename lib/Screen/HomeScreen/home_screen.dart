import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_api_app/Constants/Appbar.dart';
import 'package:pokemon_api_app/Model/Pokemons.dart';
import 'package:pokemon_api_app/Screen/HomeScreen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<List<PokemonsModel>> fetchPokemons() async {
  final url =
      'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Fetched data: $data'); // Debug print
      return data.map((json) => PokemonsModel.fromJson(json)).toList();
    } else {
      print('Failed to load data with status code: ${response.statusCode}');
      throw Exception('Failed to load Pokémon data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Error fetching data');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PokemonsModel>> futurePokemons;
  List<PokemonsModel> pokemons = [];
  List<PokemonsModel> filteredPokemons = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    futurePokemons = fetchPokemons();
  }

  Future<List<PokemonsModel>> fetchPokemons() async {
    final url =
        'https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<PokemonsModel> fetchedPokemons =
            data.map((json) => PokemonsModel.fromJson(json)).toList();
        // Set both pokemons and filteredPokemons initially
        setState(() {
          pokemons = fetchedPokemons;
          filteredPokemons = fetchedPokemons;
        });
        return fetchedPokemons;
      } else {
        print('Failed to load data with status code: ${response.statusCode}');
        throw Exception('Failed to load Pokémon data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  void filterPokemons(String query) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        filteredPokemons = pokemons;
      } else {
        filteredPokemons = pokemons
            .where((pokemon) =>
                pokemon.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 230.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 16.0, bottom: 150.0),
                  title: Text(
                    "POKÉMON",
                    style: TextStyle(
                      fontFamily: 'AntonSC',
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                  background: Stack(
                    children: [
                      Positioned(
                        left: 16.0,
                        right: 16.0,
                        bottom: 75.0,
                        child: Text(
                          "Pokémon GO has a new look! Enjoy enhanced visuals, a GO Snapshot update, and more diverse ways to express yourself with our latest updates.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        right: 16.0,
                        bottom: 10.0,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 310,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 219, 219),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextField(
                                  onChanged: filterPokemons,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(fontSize: 20),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 219, 219),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.filter_alt_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<PokemonsModel>>(
                    future: futurePokemons,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Pokémon data available'));
                      } else {
                        List<PokemonsModel> displayPokemons = searchText.isEmpty
                            ? filteredPokemons
                            : filteredPokemons
                                .where((pokemon) => pokemon.name!
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase()))
                                .toList();

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: displayPokemons.length,
                          itemBuilder: (context, index) {
                            final pokemon = displayPokemons[index];
                            List<Color> cardColors = [
                              Colors.pinkAccent,
                              Colors.blueAccent,
                              Colors.greenAccent,
                              Colors.orangeAccent,
                              Colors.purpleAccent,
                              Colors.yellowAccent,
                              Colors.tealAccent,
                            ];
                            Color color = cardColors[index % cardColors.length];

                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      index: index,
                                      pokemon: pokemon,
                                    ),
                                  ));
                                },
                                child: Card(
                                  color: color,
                                  borderOnForeground: true,
                                  child: Container(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Hero(
                                          tag: pokemon,
                                          child: Image(
                                            image: NetworkImage(
                                                '${pokemon.imageurl}'),
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                        ),
                                        Text(
                                          "${pokemon.name}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'AntonSC',
                                          ),
                                        ),
                                        Text(
                                          "${pokemon.id}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'AntonSC',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
