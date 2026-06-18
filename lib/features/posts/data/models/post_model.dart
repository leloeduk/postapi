import 'package:leloapp/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      createdAt: json['createdAt']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'body': body,
      'name': name,
      'avatar': avatar,
      "createdAt": createdAt,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? body,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return PostModel(
      id: id.toString(),
      title: title ?? this.title,
      body: body ?? this.body,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
