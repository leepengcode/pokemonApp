import 'package:flutter/material.dart';

class MySearchBAR extends StatelessWidget {
  MySearchBAR({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
                size: 30,
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 4,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search...", border: InputBorder.none),
                ),
              ),
              Container(
                height: 25,
                width: 1.5,
                color: Colors.grey,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
