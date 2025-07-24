// riverpod_toast/lib/src/toast_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'toast_theme.dart';
import 'toast_type.dart';

final toastControllerProvider =
    NotifierProvider<ToastController, List<_ToastRequest>>(ToastController.new);

class _ToastRequest {
  final String message;
  final ToastType type;
  final bool localized;
  final ToastThemeData? theme;

  _ToastRequest(this.message, this.type, this.localized, this.theme);
}

class ToastController extends Notifier<List<_ToastRequest>> {
  BuildContext? _context;
  bool _isShowing = false;

  @override
  List<_ToastRequest> build() => [];

  void registerContext(BuildContext context) {
    _context = context;
    _processQueue();
  }

  void show(
    String message, {
    ToastType type = ToastType.info,
    bool localized = false,
    ToastThemeData? theme,
    Duration? duration,
    bool isProgress = false,
  }) {
    state = [...state, _ToastRequest(message, type, localized, theme)];
    _processQueue();
  }

  void _processQueue() async {
    if (_isShowing || _context == null || state.isEmpty) return;

    final request = state.first;
    state = state.sublist(1);
    _isShowing = true;

    final widget = useNativeUiGlobally
        ? toastStyleForPlatform(
            _context!,
            request.type,
            localTheme: request.theme,
          )(request.message)
        : _buildDefaultToastWidget(request.message, request.type);

    await showToastWidget(
      widget,
      context: _context!,
      animation: StyledToastAnimation.slideFromBottomFade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 3),
    );

    _isShowing = false;
    _processQueue();
  }

  Widget _buildDefaultToastWidget(String message, ToastType type) {
    Color background;
    IconData icon;

    switch (type) {
      case ToastType.success:
        background = Colors.green;
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        background = Colors.red;
        icon = Icons.error;
        break;
      case ToastType.warning:
        background = Colors.orange;
        icon = Icons.warning;
        break;
      case ToastType.info:
        background = Colors.blue;
        icon = Icons.info;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
