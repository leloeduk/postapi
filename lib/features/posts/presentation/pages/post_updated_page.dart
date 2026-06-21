import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leloapp/features/posts/domain/entities/post.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';

import '../bloc/post_bloc.dart';

class PostUpdatedPage extends StatefulWidget {
  final Post model;
  const PostUpdatedPage({super.key, required this.model});

  @override
  State<PostUpdatedPage> createState() => _PostUpdatedPageState();
}

class _PostUpdatedPageState extends State<PostUpdatedPage> {
  // attendre plutard
  late TextEditingController nameController;
  late TextEditingController titleController;
  late TextEditingController bodyController;

  // dispose (initial)
  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  // etat initial
  @override
  void initState() {
    nameController = TextEditingController(text: widget.model.name);
    titleController = TextEditingController(text: widget.model.title);
    bodyController = TextEditingController(text: widget.model.body);
    super.initState();
  }

  File? image;

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    setState(() {
      image = File(img.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: CircleAvatar(
                radius: 100,
                backgroundImage: image != null
                    ? FileImage(image!) as ImageProvider
                    : NetworkImage(widget.model.avatar),
              ),
            ),
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
                  id: widget.model.id,
                  title: titleController.text,
                  body: bodyController.text,
                  name: nameController.text,
                  avatar: image.toString(),
                  createdAt: DateTime.now().toString(),
                );

                context.read<PostBloc>().add(UpdatePostEvent(newPost));
                Navigator.pop(context);
              },
              child: Text(
                "Mise à jour ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
