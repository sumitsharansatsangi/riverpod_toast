import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_toast/riverpod_toast.dart';

/// ✅ This registers context AFTER everything is built correctly
class ToastContextRegistrar extends ConsumerStatefulWidget {
  final Widget child;
  const ToastContextRegistrar({super.key, required this.child});

  @override
  ConsumerState<ToastContextRegistrar> createState() =>
      _ToastContextRegistrarState();
}

class _ToastContextRegistrarState extends ConsumerState<ToastContextRegistrar> {
  @override
  void initState() {
    super.initState();
    longTask();
    // Wait until the widget is in the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(toastControllerProvider.notifier);
      debugPrint("[TOAST INIT] Registering context: $context");
      controller.registerContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> longTask() async {
    await Future.delayed(const Duration(seconds: 3));
    showToastFlexible(ref, 'Long task completed!', type: ToastType.success);
  }
}
