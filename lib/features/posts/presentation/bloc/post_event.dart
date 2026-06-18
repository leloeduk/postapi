import '../../domain/entities/post.dart';

abstract class PostEvent {}

class LoadedPostEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final Post post;
  CreatePostEvent(this.post);
}

class UpdatePostEvent extends PostEvent {
  final Post post;
  UpdatePostEvent(this.post);
}

class DeletePostEvent extends PostEvent {
  final String postId;
  DeletePostEvent(this.postId);
}
