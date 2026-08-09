// lib/widgets/card_dica.dart
import 'package:flutter/material.dart';

class CardDica extends StatelessWidget {
  final String title;
  final String body;

  const CardDica({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber),
            SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 6),
                Text(body, style: Theme.of(context).textTheme.bodyText2),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
