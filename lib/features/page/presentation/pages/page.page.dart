import 'package:flutter/material.dart';

class PagePage extends StatelessWidget {
  const PagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page'),
      ),
      body: Center(
        child: Text(
          'Page Page',
        ),
      ),
    );
  }
}
