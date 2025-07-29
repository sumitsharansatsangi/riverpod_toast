import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_toast/riverpod_toast.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          children: [
            Text('This is the Settings page'),
            ElevatedButton(
              onPressed: () {
                showSuccess(ref, 'Dark Mode Activated 🌙');
              },
              child: Text("Set Dark Mode"),
            ),
            ElevatedButton(
              onPressed: () {
                showSuccess(ref, 'Light Mode Activated 🌞');
              },
              child: Text("Set Light Mode"),
            ),
          ],
        ),
      ),
    );
  }
}
