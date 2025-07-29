import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_toast/riverpod_toast.dart';
import 'package:go_router/go_router.dart';


class HomePage extends ConsumerWidget {
  const HomePage(this.isGoRouter, {super.key});
  final bool isGoRouter ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("[BUTTON] showSuccess called");
                showSuccess(ref, 'Success!');
              },
              child: const Text('Show Success'),
            ),
            ElevatedButton(
              onPressed: () => showError(ref, 'Something went wrong!'),
              child: const Text('Show Error'),
            ),
            ElevatedButton(
              onPressed: () => showWarning(ref, 'Be careful!'),
              child: const Text('Show Warning'),
            ),
            ElevatedButton(
              onPressed: () => showInfo(ref, 'Here is some info.'),
              child: const Text('Show Info'),
            ),
            if(isGoRouter)
           ElevatedButton(onPressed: (){
           context.push('/settings');
           }, child: Text("Settings")),
           if(isGoRouter)
           ElevatedButton(onPressed: (){
           context.push('/about');
           }, child: Text("About")),
          ],
        ),
      ),
    );
  }
}
