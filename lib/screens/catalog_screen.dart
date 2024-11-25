import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesgdl/screens/add_movie_screen.dart';
import 'package:moviesgdl/screens/admin_screen.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import 'movie_detail_screen.dart';
import '../models/movie.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Movie> movies = [];  // Lista de objetos Movie
  final String apiKey = 'ab62adc10308866563219b8de9f92e9e';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // ignore: use_build_context_synchronously
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final newMovies = data['results'].map<Movie>((movie) => Movie.fromApiMap(movie)).toList();
      for (final movie in newMovies) {
        try {
          await firebaseService.addMovie(movie);
        } catch (e) {
        //
        }
      }
      setState(() {
        movies = newMovies;
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Películas'),
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(movie: movie),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.imageUrl}',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await firebaseService.signOut(); 
                        Navigator.pushNamedAndRemoveUntil(
                          // ignore: use_build_context_synchronously
                          context,
                          '/', 
                          (route) => false,
                        );
                      },
                      child: const Text('Salir'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddMovieScreen()),
                        );
                      },
                      child: const Text('Agregar Película'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminScreen()),
                        );
                      },
                      child: const Text('Listado'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
