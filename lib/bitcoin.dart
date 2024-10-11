import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Bitcoin extends StatefulWidget {
  const Bitcoin({super.key});

  @override
  State<Bitcoin> createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {
  var preco = 0;
  Future<void> recuperarPreco() async {
    var response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=brl'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        preco = data['bitcoin']['brl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("imagens/bitcoin.png"),
          Text(
            "R\$" + preco.toString(),
            style: TextStyle(fontSize: 35),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: recuperarPreco,
              child: Text("Atualizar", style: TextStyle(fontSize: 20)))
        ],
      ),
    ));
  }
}
