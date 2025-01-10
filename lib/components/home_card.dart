import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final IconData icon;
  final String description;
  final Function onTap;
  const HomeCard(
      {super.key,
      required this.icon,
      required this.description,
      required this.onTap});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget
          .onTap(), // Execute the passed onTap function when the card is clicked
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon),
              SizedBox(height: 10),
              Text(
                widget.description,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
