import 'package:flutter/material.dart';
import 'package:pokemon_api_app/Model/Pokemons.dart';

class DetailScreen extends StatelessWidget {
  final PokemonsModel pokemon;
  final int index;

  DetailScreen({required this.pokemon, required this.index});

  final List<Color> cardColors = [
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
  ];

  @override
  Widget build(BuildContext context) {
    Color color = cardColors[index % cardColors.length];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: color,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      pokemon.name!,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pokemon.id.toString().padLeft(3, '0'),
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Hero(
                      tag: pokemon,
                      child: Image.network(
                        pokemon.imageurl!,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: DefaultTabController(
                length: 5,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(text: 'Forms'),
                          Tab(text: 'Detail'),
                          Tab(text: 'Types'),
                          Tab(text: 'Stats'),
                          Tab(text: 'Weaknesses'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildFormsTab(),
                          _buildDetailTab(),
                          _buildTypesTab(),
                          _buildStatsTab(),
                          _buildWeaknessesTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.network(pokemon.imageurl!, height: 50, width: 50),
            ),
            SizedBox(width: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.network(pokemon.imageurl!, height: 50, width: 50),
            ),
            SizedBox(width: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.network(pokemon.imageurl!, height: 50, width: 50),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Mega Evolution',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'In order to support its flower, which has grown larger due to Mega Evolution, its back and legs have become stronger.',
        ),
      ],
    );
  }

  Widget _buildDetailTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(pokemon.xdescription ?? pokemon.ydescription ?? ''),
          SizedBox(height: 8),
          Text(
            'Height: ${pokemon.height}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Weight: ${pokemon.weight}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Category: ${pokemon.category}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Abilities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTypesTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type of Pokémon',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Base Stats',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('HP: ${pokemon.hp}'),
          Text('Attack: ${pokemon.attack}'),
          Text('Defense: ${pokemon.defense}'),
          Text('Speed: ${pokemon.speed}'),
          Text('Total: ${pokemon.total}'),
        ],
      ),
    );
  }

  Widget _buildWeaknessesTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weaknesses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
