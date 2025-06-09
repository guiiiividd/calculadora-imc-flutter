import 'package:p2_guilherme_abreu_vidal/database/database.dart';
import 'package:p2_guilherme_abreu_vidal/screens/calculadora_imc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p2_guilherme_abreu_vidal/screens/tela_cadastro.dart';
import 'package:p2_guilherme_abreu_vidal/styles/styles.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  TelaLoginState createState() => TelaLoginState();
}

class TelaLoginState extends State<TelaLogin> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final databaseHelper = DatabaseHelper();

  void realizarLogin() async {
    if (formKey.currentState!.validate()) {
      final user = await databaseHelper.getUser(emailController.text);
      if (user != null && user['password'] == senhaController.text) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculadoraIMC(nome: user['nomeSobrenome']),
          ),
        );
        limparCampos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha invalidos!')),
        );
      }
    }
  }

  void limparCampos() {
    emailController.clear();
    senhaController.clear();
  }

  void printAllUsers() async {
    final users = await databaseHelper.getAllUsers();
    for (var user in users) {
      if (kDebugMode) {
        print('User: ${user['email']}, Password: ${user['password']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logoIMC.png', height: 70),
            SizedBox(width: 5),
            Text(
              'IMC Tracker',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Text('Login'.toUpperCase(), style: AppStyles.titleText),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: AppStyles.fontBlack,
                        hintStyle: AppStyles.fontBlack,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite o seu e-mail!';
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}',
                        ).hasMatch(value)) {
                          return 'Digite um endereço de e-mail válido!';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.sizedBoxHeight),

                    // Input de Senha
                    TextFormField(
                      controller: senhaController,
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: AppStyles.fontBlack,
                        hintStyle: AppStyles.fontBlack,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite a sua senha!';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 8 caracteres!';
                        } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                          return 'A senha deve ter pelo menos uma letra!';
                        } else if (!RegExp(r'\d').hasMatch(value)) {
                          return 'A senha deve ter pelo menos um número!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.sizedBoxHeight),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: realizarLogin,
                            style: AppStyles.buttonStyle,
                            child: Text(
                              'Login'.toUpperCase(),
                              style: AppStyles.buttonText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sizedBoxHeight),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaCadastro()),
                  );
                },
                child: Text(
                  'Não tem conta? Cadastre-se aqui!',
                  style: AppStyles.linkStyle,
                ),
                style: AppStyles.transparentButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
