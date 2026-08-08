
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/sqlite_chat_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../dominian/repositories/chat_repository.dart';
import 'app_database_provider.dart';

final repositoryProvider = Provider<ChatRepository>((ref) {
  final appDatabase = ref.read(appDatabaseProvider);

  return ChatRepositoryImpl(
    dataSource: SQLiteChatDataSource(appDatabase: appDatabase),
  );
});