import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leloapp/features/posts/domain/entities/post.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';

import '../bloc/post_bloc.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page Edit ")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Votre Nom"),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text("Title"),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text("Body"),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                final newPost = Post(
                  id: "",
                  title: titleController.text,
                  body: bodyController.text,
                  name: nameController.text,
                  avatar: "",
                  createdAt: DateTime.now().toString(),
                );
                context.read<PostBloc>().add(CreatePostEvent(newPost));
                Navigator.pop(context);
              },
              child: Text(
                "Créer un post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
