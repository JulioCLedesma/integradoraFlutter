import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieForm extends StatefulWidget {
  const MovieForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String year = '';
  String director = '';
  String genre = '';
  String synopsis = '';
  String imageUrl = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FirebaseFirestore.instance.collection('movies').add({
        'title': title,
        'year': year,
        'director': director,
        'genre': genre,
        'synopsis': synopsis,
        'imageUrl': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Película agregada con éxito')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => title = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Año'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => year = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Director'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => director = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Género'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => genre = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Sinopsis'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => synopsis = value!,
            maxLines: 3,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'URL de la imagen'),
            validator: (value) => value!.isEmpty ? 'Este campo es requerido' : null,
            onSaved: (value) => imageUrl = value!,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Agregar Película'),
          ),
        ],
      ),
    );
  }
}