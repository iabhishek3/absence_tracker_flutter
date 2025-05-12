import 'package:flutter/material.dart';

class AbsenceListPage extends StatelessWidget {
  const AbsenceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Center(
        child: Text(
          "Hi world!",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
} 