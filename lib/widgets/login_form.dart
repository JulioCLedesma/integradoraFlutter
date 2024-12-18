import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class LoginForm extends StatefulWidget {
  final FirebaseService firebaseService;

  const LoginForm({super.key, required this.firebaseService});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu correo electrónico';
                }
                return null; 
              },
              keyboardType: TextInputType.emailAddress, 
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu contraseña';
                }
                return null; 
              },
            ),
            const SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await widget.firebaseService.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                    
                    if (!mounted) return;
                    
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/catalog');
                  } catch (e) {
                    
                    if (!mounted) return;

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al iniciar sesión: $e')),
                    );
                  }
                }
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}