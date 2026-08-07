
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/data/database/SQLiteChatDataSource.dart';


import '../../data/repositories/ChatRepositoryImpl.dart';
import '../../dominian/repositories/chat_repository.dart';
import 'app_database_provider.dart';

final repositoryProvider = Provider<ChatRepository>((ref) {
  final appDatabase = ref.read(appDatabaseProvider);

  return ChatRepositoryImpl(
    dataSource: SQLiteChatDataSource(appDatabase: appDatabase),
  );
});