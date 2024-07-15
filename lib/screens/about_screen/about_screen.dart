import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _text(text: 'CryptoGem', fontSize: 24, fontWeight: FontWeight.bold),
            const SizedBox(height: 20),
            _text(text: 'Atividade para Dispositivos Móveis - IFPI'),
            _text(text: 'API utilizada: CoinGecko'),
            _text(text: 'Desenvolvido por: Gabriel Rocha'),
            _text(text: 'Github: RochaGabriell'),
            const SizedBox(height: 20),
            _text(
              text: 'Versão 1.0.0',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Text _text({
    required String text,
    double? fontSize = 18,
    FontWeight? fontWeight = FontWeight.normal,
    TextAlign? textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}
