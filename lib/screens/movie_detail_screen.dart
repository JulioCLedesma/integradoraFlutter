import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movieId, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Película'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie.imageUrl),
            const SizedBox(height: 16),
            Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Año: ${movie.year}'),
            Text('Director: ${movie.director}'),
            Text('Género: ${movie.genre}'),
            const SizedBox(height: 16),
            const Text('Sinopsis:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(movie.synopsis),
          ],
        ),
      ),
    );
  }
}