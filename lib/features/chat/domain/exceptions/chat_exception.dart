enum ChatError {
  update,
  notFound,
  network,
  unknown;

  String get message {
    return switch (this) {
      ChatError.update => 'No se pudo actualizar el chat.',
      ChatError.notFound => 'El chat no está disponible.',
      ChatError.network => 'No hay conexión a Internet.',
      ChatError.unknown => 'Ocurrió un error inesperado. Inténtalo nuevamente.',
    };
  }
}

class ChatException implements Exception {
  final ChatError error;
  final Object? cause;
  final StackTrace? stackTrace;

  const ChatException(this.error, {this.cause, this.stackTrace});

  @override
  String toString() => 'ChatException: ${error.message}';
}
