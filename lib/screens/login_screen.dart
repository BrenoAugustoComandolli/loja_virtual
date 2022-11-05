import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SignupScreen()));
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              primary: primary,
            ),
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text!.isEmpty || !text.contains("@")) {
                      return "E-mail inválido!";
                    }
                    return '';
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: const InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 6) {
                      return "Senha inválida!";
                    }
                    return '';
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Insira seu e-mail para recuperação!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Confira seu e-mail!"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primary,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSucess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Falha ao entrar!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
