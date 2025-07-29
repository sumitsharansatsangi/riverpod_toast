import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_toast/riverpod_toast.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Column(
          children: [
            Text('This is the About page'),
            ElevatedButton(
              onPressed: () {
                showInfo(ref, "Riverpod Toast is a toast library for Riverpod");
              },
              child: Text("About Riverpod Toast"),
            ),
          ],
        ),
      ),
    );
  }
}
