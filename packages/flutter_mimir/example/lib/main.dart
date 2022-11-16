import 'package:flutter/material.dart';
import 'package:flutter_mimir/flutter_mimir.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final instance = await Mimir.defaultInstance;
  runApp(MaterialApp(
    title: 'Mimir Demo',
    home: Scaffold(
      appBar: AppBar(title: const Text('Mimir Demo')),
      body: Body(instance: instance),
    ),
  ));
}

class Body extends StatelessWidget {
  const Body({super.key, required this.instance});

  final MimirInstance instance;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
