class ChatException implements Exception {
  final ChatError error;
  final Object? cause;
  final StackTrace? stackTrace;

  ChatException(this.error, {this.cause, this.stackTrace});
}

enum ChatError {
  update,
  notFound,
  network,
  unknown
}

//Definicionde los mensajes de error
extension ChatErrorMessage on ChatError {
  String get message {
    switch (this) {
      case ChatError.update:
        return 'No se pudo actualizar el chat.';

      case ChatError.notFound:
        return 'El chat no está disponible.';

      case ChatError.network:
        return 'No hay conexión a Internet.';

      case ChatError.unknown:
        return 'Ocurrió un error inesperado. Inténtalo nuevamente.';
    }
  }
}
