import 'package:flutter_provider/flutter_provider.dart';

import '../../data/datasources/mock_chat_datasource.dart';

import '../../dominian/repositories/chat_repository.dart';

final repositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    dataSource: MockChatDataSource(),
  );
});