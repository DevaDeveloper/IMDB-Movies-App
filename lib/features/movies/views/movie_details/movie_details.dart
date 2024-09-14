import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: InkWell(
              onTap: () {
                context.pop();
              },
              child: Text(
                'Movie details',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
