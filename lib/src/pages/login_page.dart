import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trespaginas/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text('Bem-vindo',
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
                          hintText: 'Informe o e-mail para login',
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
                          email = value!;
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
                          hintText: 'Informe sua senha para login',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Senha é obrigatória';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          senha = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        child: const Text('Entrar'),
                      ),
                      Column(
                        children: [
                          const SizedBox(width: 20, height: 20),
                          const Text('Não possui uma conta ainda?'),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: const Text('Clique aqui'))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  _login(BuildContext context) {
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      return _signIn();
    }
  }

  Future _signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha);
  }
}
