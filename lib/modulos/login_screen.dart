import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _obscurePassword = true;

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _login() {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email != 'ajcastron@unah.hn') {
      _showError('Correo incorrecto.');
      return;
    }

    if (password != '20192002956') {
      _showError('Contraseña incorrecta.');
      return;
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Inicio de Sesión',
          style: TextStyle(
            fontSize: 37,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomTextField(controller: _emailCtrl, label: 'Correo'),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _passwordCtrl,
              label: 'Contraseña (Número de cuenta)',
              isPassword: true,
              obscureText: _obscurePassword,
              toggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Fondo verde
                foregroundColor: Colors.white, // Texto blanco (opcional)
              ),
            ),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text('¿No tienes cuenta? Regístrate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
