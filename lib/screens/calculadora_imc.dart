import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p2_guilherme_abreu_vidal/styles/styles.dart';

class CalculadoraIMC extends StatefulWidget {
  final String nome;

  const CalculadoraIMC({super.key, required this.nome});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  Timer? _timer;
  String mensagemBoasVindas = '';
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double imc = 0;
  String situacao = '';

  Color estadoCor = Colors.transparent;
  Color resultadoCor = Colors.transparent;
  Color iconColor = AppColors.primaryColor;

  String _getCurrentHour() {
    return DateFormat('HH').format(DateTime.now());
  }

  void _exibirMensagemBoasVindas() {
    String msg = "";
    double hour = double.parse(_getCurrentHour());

    if (hour >= 5 && hour < 12) {
      msg = "Bom dia, ${widget.nome}!";
    } else if (hour >= 12 && hour < 18) {
      msg = "Boa tarde, ${widget.nome}!";
    } else {
      msg = "Boa noite, ${widget.nome}!";
    }

    setState(() {
      mensagemBoasVindas = msg;
    });
  }

  @override
  void initState() {
    super.initState();
    _exibirMensagemBoasVindas();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _atualizar() {
    _pesoController.clear();
    _alturaController.clear();
  }

  void _calcularIMC() {
    double peso = double.parse(_pesoController.text);
    double altura = double.parse(_alturaController.text) / 100;

    imc = peso / pow(altura, 2);

    if (imc != 0.0) {
      setState(() {
        resultadoCor = Colors.black;

        if (imc < 16) {
          situacao = "magreza grave";
          estadoCor = Colors.red;
          iconColor = Colors.red;
        } else if (imc >= 16 && imc <= 16.9) {
          situacao = "magreza moderada";
          estadoCor = Colors.deepOrange;
          iconColor = Colors.deepOrange;
        } else if (imc >= 17 && imc <= 18.5) {
          situacao = "magreza leve";
          estadoCor = Colors.orange;
          iconColor = Colors.orange;
        } else if (imc >= 18.6 && imc <= 24.9) {
          situacao = "peso ideal";
          estadoCor = Colors.green;
          iconColor = Colors.green;
        } else if (imc >= 25 && imc <= 29.9) {
          situacao = "sobrepeso";
          estadoCor = Colors.yellow;
          iconColor = Colors.yellow;
        } else if (imc >= 30 && imc <= 34.9) {
          situacao = "obesidade grau I";
          estadoCor = Colors.orange;
          iconColor = Colors.orange;
        } else if (imc >= 35 && imc <= 39.9) {
          situacao = "obesidade grau II ou severa";
          estadoCor = Colors.deepOrange;
          iconColor = Colors.deepOrange;
        } else if (imc > 40) {
          situacao = "obesidade grau III ou mórbida";
          estadoCor = Colors.red;
          iconColor = Colors.red;
        } else {
          situacao = "IMC inválido";
          imc = 0.0;
        }
      });
    }

    // print("Peso: ${peso}");
    // print("Altura: ${altura}");
    // print("IMC: ${imc}");
    // print("Situação: ${situacao}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
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
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.refresh, color: AppColors.appBarIconColor),
                onPressed: _atualizar,
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app, color: AppColors.appBarIconColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.bodyPadding),
        child: Column(
          children: [
            Text(
              mensagemBoasVindas,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.sizedBoxHeight),
            Icon(Icons.person, size: AppSize.bodyIconSize, color: iconColor),
            SizedBox(height: AppSpacing.sizedBoxHeight),

            // Input peso
            TextFormField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              cursorColor: AppColors.black,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                labelStyle: TextStyle(color: AppColors.black),
                hintStyle: TextStyle(color: AppColors.black),
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
                  return 'Digite o seu peso!';
                } else if (!(double.parse(value) > 0 &&
                    double.parse(value) <= 635)) {
                  return "Digite um peso válido!";
                }
              },
            ),
            SizedBox(height: AppSpacing.sizedBoxHeight),

            // Input Altura
            TextFormField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              cursorColor: AppColors.black,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: AppColors.black),
                hintStyle: TextStyle(color: AppColors.black),
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
                  return 'Digite a sua altura!';
                } else if (!(double.parse(value) > 0 &&
                    double.parse(value) <= 272)) {
                  return "Digite uma altura válida!";
                }
              },
            ),
            SizedBox(height: AppSpacing.sizedBoxHeight),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calcularIMC,
                    style: AppStyles.buttonStyle,
                    child: Text(
                      'Calcular'.toUpperCase(),
                      style: AppStyles.buttonText,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sizedBoxHeight),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Seu IMC é ',
                    style: TextStyle(color: resultadoCor),
                  ),
                  TextSpan(
                    text: imc.toStringAsFixed(2),
                    style: TextStyle(
                      color: estadoCor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '. Você está com ',
                    style: TextStyle(color: resultadoCor),
                  ),
                  TextSpan(
                    text: situacao + '!',
                    style: TextStyle(
                      color: estadoCor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
