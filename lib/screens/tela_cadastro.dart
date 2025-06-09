import 'package:p2_guilherme_abreu_vidal/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p2_guilherme_abreu_vidal/screens/tela_login.dart';
import 'package:p2_guilherme_abreu_vidal/styles/styles.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  TelaCadastroState createState() => TelaCadastroState();
}

class TelaCadastroState extends State<TelaCadastro> {
  final formKey = GlobalKey<FormState>();
  final nomeSobrenomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final repetirSenhaController = TextEditingController();
  final databaseHelper = DatabaseHelper();

  void realizarCadastro() async {
    if (formKey.currentState!.validate()) {
      bool emailJaCadastrado = await DatabaseHelper.instance.emailJaCadastrado(
        emailController.text,
      );
      if (!emailJaCadastrado) {
        await databaseHelper.insertUser(
          nomeSobrenomeController.text,
          emailController.text,
          senhaController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário registrado com sucesso!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelaLogin()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('E-mail já cadastrado!')));
      }
    }
  }

  Future<bool> validarSenhas() async {
    if (senhaController.text == repetirSenhaController.text) {
      return true;
    } else {
      return false;
    }
  }

  void limparCampos() {
    emailController.clear();
    senhaController.clear();
    repetirSenhaController.clear();
    nomeSobrenomeController.clear();
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
                    Text('Cadastro'.toUpperCase(), style: AppStyles.titleText),
                    SizedBox(height: AppSpacing.sizedBoxHeight),
                    // Input de Nome e sobrenome
                    TextFormField(
                      controller: nomeSobrenomeController,
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        labelText: 'Nome e Sobrenome',
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
                          return 'Por favor digite o seu nome e sobrenome';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.sizedBoxHeight),

                    // Input de E-mail
                    TextFormField(
                      controller: emailController,
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
                          return 'Por favor digite o seu e-mail';
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}',
                        ).hasMatch(value)) {
                          return 'Por favor digite um endereço de e-mail válido';
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
                          return 'Por favor, digite sua senha';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.sizedBoxHeight),

                    // Input de Repetir Senha
                    TextFormField(
                      controller: repetirSenhaController,
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        labelText: 'Repetir Senha',
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
                          return 'Por favor, digite sua senha';
                        } else if (value != senhaController.text) {
                          return 'As senhas devem ser iguais';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.sizedBoxHeight),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: realizarCadastro,
                            style: AppStyles.buttonStyle,
                            child: Text(
                              'Cadastrar'.toUpperCase(),
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
                    MaterialPageRoute(builder: (context) => TelaLogin()),
                  );
                },
                child: Text('Já possuo cadastro!', style: AppStyles.linkStyle),
                style: AppStyles.transparentButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
