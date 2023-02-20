import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.of(context).pushReplacementNamed('/home/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PlaceholderLines(
                count: 7,
                animate: true,
                align: TextAlign.center,
                lineHeight: 10,
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
              Text(
                'Estamos carregando o chat, por favor aguarde...',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
