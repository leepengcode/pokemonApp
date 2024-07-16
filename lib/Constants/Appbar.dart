import 'package:flutter/material.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100.0; // Minimum height when collapsed
  @override
  double get maxExtent => 200.0; // Maximum height when expanded

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      child: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16.0, bottom: 130.0),
        title: Text(
          "POKÉMON",
          style: TextStyle(
            fontFamily: 'AntonSC',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        background: Stack(
          children: [
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 65.0,
              child: Text(
                "Pokémon GO has a new look! Enjoy enhanced visuals, a GO Snapshot update, and more diverse ways to express yourself with our latest updates.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 10.0,
              child: Row(
                children: [
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 219, 219),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          hintText: 'Search...',
                          hintStyle: TextStyle(fontSize: 20),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 219, 219),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        prefixIcon: Icon(Icons.filter_alt_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
