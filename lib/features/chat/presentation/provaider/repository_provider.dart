import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/mock_chat_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../dominian/repositories/chat_repository.dart';

final repositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    dataSource: MockChatDataSource(),
  );
});