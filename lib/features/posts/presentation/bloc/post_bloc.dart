import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repos;
  PostBloc(this.repos) : super(PostInitialState()) {
    on<LoadedPostEvent>(onLoadPost);
    on<CreatePostEvent>(onCreatePost);
    on<UpdatePostEvent>(onUpdatePost);
    on<DeletePostEvent>(onDeletePost);
  }

  Future<void> onLoadPost(
    LoadedPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      final posts = await repos.getAllPosts();
      print("bloc ${posts.length}");
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future<void> onCreatePost(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      await repos.createPost(event.post);
      add(LoadedPostEvent());
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future<void> onUpdatePost(
    UpdatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      await repos.updatePost(event.post);
      add(LoadedPostEvent());
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future<void> onDeletePost(
    DeletePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      await repos.deletePost(event.postId);
      add(LoadedPostEvent());
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
}
