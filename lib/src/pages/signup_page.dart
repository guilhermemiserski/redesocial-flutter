import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _senha = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('Criar conta',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              const SizedBox(
                width: 30,
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Informe o e-mail para criar a conta',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  if (!value.contains('@')) {
                    return 'Email precisa de @';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  hintText: 'Informe sua senha para criar a conta',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  return null;
                },
                onSaved: (value) {
                  _senha = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _validar(context);
                },
                child: const Text('Criar conta'),
              ),
              Column(
                children: [
                  const SizedBox(width: 20, height: 20),
                  const Text('Já possui uma conta?'),
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: const Text('Clique aqui'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validar(BuildContext context) {
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      return _signUp(context);
    }
  }

  Future<void> _signUp(BuildContext context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _senha);
    final user = FirebaseAuth.instance.currentUser!;
    final isVerified = user.emailVerified;
    if (!isVerified) {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }
    if (isVerified) {
      Navigator.pushNamed(context, '/login');
    }
  }
}
