import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: RegisterForm(firebaseService: firebaseService),
    );
  }
}