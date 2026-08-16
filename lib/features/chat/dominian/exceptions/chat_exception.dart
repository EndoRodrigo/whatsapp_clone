class ChatException implements Exception {
  final ChatError error;

  ChatException(this.error);
}

enum ChatError {
  update,
  notFound,
  network,
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
    }
  }
}
