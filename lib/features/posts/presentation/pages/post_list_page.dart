import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_bloc.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';
import 'package:leloapp/features/posts/presentation/pages/post_updated_page.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_state.dart';
import 'post_edit_page.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String query = "";
  TextEditingController searchController = TextEditingController();

  List<Post> listPosts(List<Post> posts) {
    if (query.isEmpty) {
      return posts;
    }
    return posts.where((data) {
      return data.name.toLowerCase().contains(query.toLowerCase()) ||
          data.title.contains(query.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    context.read<PostBloc>().add(LoadedPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextFormField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(),
          ),
        ),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: listPosts(state.posts).length,
              itemBuilder: (context, index) {
                final currentIndex = listPosts(state.posts)[index];
                return Dismissible(
                  key: Key(currentIndex.id),
                  onDismissed: (direction) {
                    context.read<PostBloc>().add(
                      DeletePostEvent(currentIndex.id),
                    );
                  },
                  // direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.delete, size: 80, color: Colors.white),
                  ),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PostUpdatedPage(model: currentIndex),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  currentIndex.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    currentIndex.avatar,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentIndex.createdAt),
                                Text(currentIndex.title),
                                Text(currentIndex.body),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<PostBloc>().add(LoadedPostEvent());
              },
              child: Text("Charger les données"),
            ),
          );
        },
        listener: (context, state) {
          if (state is PostErrorState) {
            ScaffoldMessenger(child: SnackBar(content: Text(state.message)));
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostEditPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
