import 'package:flutter/material.dart';
import '../widgets/movie_form.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administración de Películas'),
      ),
      body: const MovieForm(),
    );
  }
}