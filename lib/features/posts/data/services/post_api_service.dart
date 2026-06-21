import 'package:dio/dio.dart';
import 'package:leloapp/features/posts/data/models/post_model.dart';

class PostApiService {
  final Dio dio = Dio();
  final url = "https://6a2f4979c9776ca6c0c55d96.mockapi.io/posts";
  // obtenir les données (GET)
  Future<List<PostModel>> apiGetAllPosts() async {
    final response = await dio.get(url);
    // print(" APi : ${response.data}");
    return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
  }

  // creer les données (POST)
  Future<PostModel> apiCreatePost(PostModel post) async {
    final response = await dio.post(url, data: post.toJson());
    return PostModel.fromJson(response.data);
  }

  // mettre a jour
  Future<PostModel> apiUpdatePost(PostModel post) async {
    print("test");
    final response = await dio.put("$url/${post.id}", data: post.toJson());
    print(response.statusCode);
    return PostModel.fromJson(response.data);
  }

  // suprimer
  Future<void> apiDeletePost(String postId) async {
    await dio.delete("$url/$postId");
  }
}
