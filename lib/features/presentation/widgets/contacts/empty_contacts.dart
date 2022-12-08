import 'package:flutter/material.dart';

class EmptyContacts extends StatelessWidget {
  final String message;

  const EmptyContacts({super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(message,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }
}
