import 'package:flutter/material.dart';

class LoadingSceen extends StatelessWidget {
  const LoadingSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JPVB Chat'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
