class Chat {
  final int? id;
  final String name;
  final String lastMessage;
  final String hour;
  final bool isFavorite;
  final bool isRead;
  final String? photoUrl;
  final bool isArchived;

  Chat({
    this.id,
    required this.name,
    required this.lastMessage,
    required this.hour,
    this.isFavorite = false,
    this.isRead = false,
    this.photoUrl,
    this.isArchived = false,
  });

  Chat copyWith({
    int? id,
    String? name,
    String? lastMessage,
    String? hour,
    bool? isFavorite,
    bool? isRead,
    String? photoUrl,
    bool? isArchived,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      hour: hour ?? this.hour,
      isFavorite: isFavorite ?? this.isFavorite,
      isRead: isRead ?? this.isRead,
      photoUrl: photoUrl ?? this.photoUrl,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as int,
      name: map['name'] as String,
      lastMessage: map['lastMessage'] as String,
      hour: map['hour'] as String,
      isFavorite: map['isFavorite'] == 1,
      isRead: map['isRead'] == 1,
      photoUrl: map['photoUrl'] as String?,
      isArchived: map['isArchived'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
  final map = <String, dynamic>{
    'name': name,
    'lastMessage': lastMessage,
    'hour': hour,
    'isFavorite': isFavorite ? 1 : 0,
    'isRead': isRead ? 1 : 0,
    'photoUrl': photoUrl,
    'isArchived': isArchived ? 1 : 0,
  };

  if (id != null) {
    map['id'] = id;
  }

  return map;
}
}
