import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String director;
  final String genre;
  final String synopsis;
  final String imageUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.genre,
    required this.synopsis,
    required this.imageUrl,
  });

  // Constructor para crear una instancia de Movie desde un DocumentSnapshot
  factory Movie.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Movie(
      id: snapshot.id,
      title: data['title'] ?? '',
      year: data['year'] ?? '',
      director: data['director'] ?? '',
      genre: data['genre'] ?? '',
      synopsis: data['synopsis'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Método para convertir la instancia de Movie a un Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'director': director,
      'genre': genre,
      'synopsis': synopsis,
      'imageUrl': imageUrl,
    };
  }

  // Método para crear una copia de Movie con campos actualizados
  Movie copyWith({
    String? title,
    String? year,
    String? director,
    String? genre,
    String? synopsis,
    String? imageUrl,
  }) {
    return Movie(
      id: id,
      title: title ?? this.title,
      year: year ?? this.year,
      director: director ?? this.director,
      genre: genre ?? this.genre,
      synopsis: synopsis ?? this.synopsis,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}