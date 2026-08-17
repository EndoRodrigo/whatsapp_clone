import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/presentation/provider/chat_provider.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/custom_snackbar.dart';

class ChatErrorListener extends ConsumerWidget {
  final Widget child;

  const ChatErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(chatProvider, (previous, next) {
      if (!next.isLoading && next.hasError) {
        showCustomSnackBar(context, next.error.toString());
      }
    });

    return child;
  }
}
