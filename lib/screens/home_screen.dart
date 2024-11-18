import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'catalog_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieGDL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a MovieGDL',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Iniciar Sesión'),
              onPressed: () => _signIn(context),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Registrarse'),
              onPressed: () => _register(context),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    try {
      // In a real app, get email and password from user input
      await _firebaseService.signIn('user@example.com', 'password');
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const CatalogScreen()),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  void _register(BuildContext context) async {
    try {
      // In a real app, get email and password from user input
      await _firebaseService.register('newuser@example.com', 'password');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    }
  }
}