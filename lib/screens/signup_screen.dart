import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _namedController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Criar conta"),
        centerTitle: true,
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
                  controller: _namedController,
                  decoration: const InputDecoration(
                    hintText: "Nome Completo",
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Nome inválido!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
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
                    return null;
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
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    hintText: "Endereço",
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Endereço inválido!";
                    }
                    return null;
                  },
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
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _namedController.text,
                          "email": _emailController.text,
                          "address": _addressController.text,
                        };

                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSucess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: const Text(
                      "Criar conta",
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 2),).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

}
