import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';
import '../models/movie.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Películas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movies').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var movieDoc = snapshot.data!.docs[index];
              var movie = Movie.fromSnapshot(movieDoc);
              return MovieCard(
                title: movie.title,
                imageUrl: movie.imageUrl,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movieId: movie.id, movie: movie),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}