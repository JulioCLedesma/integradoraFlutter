import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/movie.dart';


class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _imageUrlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView( // Permite scroll si el formulario es largo
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                ),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Año'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _directorController,
                  decoration: const InputDecoration(labelText: 'Director'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                ),
                TextFormField(
                  controller: _genreController,
                  decoration: const InputDecoration(labelText: 'Género'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                ),
                TextFormField(
                  controller: _synopsisController,
                  decoration: const InputDecoration(labelText: 'Sinopsis'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                  maxLines: 4,
                ),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: 'URL de la imagen'),
                  validator: (value) => value == null || value.isEmpty ? 'Este campo es requerido' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final movie = Movie(
                        id: '', // El ID se genera en Firestore
                        title: _titleController.text,
                        year: _yearController.text,
                        director: _directorController.text,
                        genre: _genreController.text,
                        synopsis: _synopsisController.text,
                        imageUrl: _imageUrlController.text,
                      );
                      try {
                        await firebaseService.addMovie(movie);
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Película agregada')),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context); // Regresar a la pantalla anterior
                      } catch (e) {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al agregar película: $e')),
                        );
                      }
                    }
                  },
                  child: const Text('Agregar Película'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _directorController.dispose();
    _genreController.dispose();
    _synopsisController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}