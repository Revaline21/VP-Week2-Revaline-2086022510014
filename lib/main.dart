import 'package:flutter/material.dart';
import 'Features/Screen/vault_screen.dart';

void main() => runApp(const VaultApp());

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collector Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const VaultScreen(),
    );
  }
}