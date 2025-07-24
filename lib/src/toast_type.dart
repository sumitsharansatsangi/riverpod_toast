import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

extension ToastTypeStyle on ToastType {
  Color get background => switch (this) {
    ToastType.success => Colors.green,
    ToastType.error => Colors.red,
    ToastType.warning => Colors.orange,
    ToastType.info => Colors.blueGrey,
  };

  IconData get icon => switch (this) {
    ToastType.success => Icons.check_circle,
    ToastType.error => Icons.error,
    ToastType.warning => Icons.warning,
    ToastType.info => Icons.info_outline,
  };
}
