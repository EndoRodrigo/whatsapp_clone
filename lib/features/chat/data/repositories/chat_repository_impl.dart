import 'package:whatsapp_clone/features/chat/domain/exceptions/chat_exception.dart';
import '../../domain/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_datasource.dart';
import '../exceptions/chat_not_found_exception.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  const ChatRepositoryImpl({required ChatDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<List<Chat>> getChats() async {
    try {
      return await _dataSource.getChats();
    } catch (e, stackTrace) {
      throw ChatException(ChatError.unknown, cause: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<Chat> addChat(Chat chat) async {
    try {
      return await _dataSource.addChat(chat);
    } catch (e, stackTrace) {
      throw ChatException(ChatError.unknown, cause: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> deleteChat(int id) async {
    try {
      await _dataSource.deleteChat(id);
    } on ChatNotFoundException {
      throw const ChatException(ChatError.notFound);
    } catch (e, stackTrace) {
      throw ChatException(ChatError.unknown, cause: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<Chat> toggleFavorite(int id) async {
    try {
      return await _dataSource.toggleFavorite(id);
    } on ChatNotFoundException {
      throw const ChatException(ChatError.notFound);
    } catch (e, stackTrace) {
      throw ChatException(ChatError.update, cause: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<Chat> toggleRead(int id) async {
    try {
      return await _dataSource.toggleRead(id);
    } on ChatNotFoundException {
      throw const ChatException(ChatError.notFound);
    } catch (e, stackTrace) {
      throw ChatException(ChatError.update, cause: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<Chat> toggleArchived(int id) async {
    try {
      return await _dataSource.toggleArchived(id);
    } on ChatNotFoundException {
      throw const ChatException(ChatError.notFound);
    } catch (e, stackTrace) {
      throw ChatException(ChatError.update, cause: e, stackTrace: stackTrace);
    }
  }
}
