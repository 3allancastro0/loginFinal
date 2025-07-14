import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _obscurePassword = true;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _register() {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final password = _passwordCtrl.text;

    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      _showError('Todos los campos son obligatorios.');
      return;
    }
    if (!email.endsWith('@unah.hn')) {
      _showError('El correo debe ser institucional (@unah.hn).');
      return;
    }
    if (password.length < 6 || !specialCharRegex.hasMatch(password)) {
      _showError(
        'La contraseña debe tener al menos 6 caracteres y un carácter especial.',
      );
      return;
    }

    // Si pasa todas las validaciones, navegamos a login
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomTextField(controller: _nameCtrl, label: 'Nombre'),
            const SizedBox(height: 12),
            CustomTextField(controller: _emailCtrl, label: 'Correo'),
            const SizedBox(height: 12),
            CustomTextField(controller: _phoneCtrl, label: 'Teléfono'),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _passwordCtrl,
              label: 'Contraseña',
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
              onPressed: _register,
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
