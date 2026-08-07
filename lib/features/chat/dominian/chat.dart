class Chat {
  final int id;
  final String name;
  final String lastMessage;
  final String hour;
  final bool isRead;
  final bool isFavorite;

  const Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.hour,
    required this.isRead,
    required this.isFavorite,
  });

  Chat copyWith({
    int? id,
    String? name,
    String? lastMessage,
    String? hour,
    bool? isRead,
    bool? isFavorite,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      hour: hour ?? this.hour,
      isRead: isRead ?? this.isRead,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      name: map['name'],
      lastMessage: map['lastMessage'],
      hour: map['hour'],
      isRead: map['isRead'] == 1,
      isFavorite: map['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'hour': hour,
      'isRead': isRead ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}