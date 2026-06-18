// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leloapp/features/posts/domain/entities/post.dart';
// import 'package:leloapp/features/posts/presentation/bloc/post_bloc.dart';
// import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';

// class PostUpdatePage extends StatefulWidget {
//   final Post post;
//   const PostUpdatePage({super.key, required this.post});

//   @override
//   State<PostUpdatePage> createState() => _PostUpdatePageState();
// }

// class _PostUpdatePageState extends State<PostUpdatePage> {
//   late TextEditingController titleController;
//   late TextEditingController bodyController;
//   late TextEditingController nameController;
//   late TextEditingController avatarController;

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.post.title);
//     bodyController = TextEditingController(text: widget.post.body);
//     nameController = TextEditingController(text: widget.post.name);
//     avatarController = TextEditingController(text: widget.post.avatar);
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     bodyController.dispose();
//     nameController.dispose();
//     avatarController.dispose();
//     super.dispose();
//   }

//   void _updatePost() {
//     final updatedPost = Post(
//       id: widget.post.id,
//       title: titleController.text,
//       body: bodyController.text,
//       name: nameController.text,
//       avatar: avatarController.text,
//       createdAt: widget.post.createdAt,
//     );
//     context.read<PostBloc>().add(UpdatePost(updatedPost));
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Modifier le post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Titre',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: bodyController,
//               decoration: const InputDecoration(
//                 labelText: 'Contenu',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Nom',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: avatarController,
//               decoration: const InputDecoration(
//                 labelText: 'Avatar URL',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _updatePost,
//                 child: const Text('Enregistrer'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
