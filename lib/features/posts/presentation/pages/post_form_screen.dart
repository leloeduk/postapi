// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leloapp/features/posts/domain/entities/post.dart';
// import 'package:leloapp/features/posts/presentation/bloc/post_bloc.dart';
// import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';

// class PostFormScreen extends StatefulWidget {
//   final Post? post;
//   const PostFormScreen({super.key, this.post});

//   @override
//   State<PostFormScreen> createState() => _PostFormScreenState();
// }

// class _PostFormScreenState extends State<PostFormScreen> {
//   late TextEditingController titleController;
//   late TextEditingController bodyController;
//   late TextEditingController nameController;
//   late TextEditingController avatarController;

//   bool get isEditing => widget.post != null;

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.post?.title ?? '');
//     bodyController = TextEditingController(text: widget.post?.body ?? '');
//     nameController = TextEditingController(text: widget.post?.name ?? '');
//     avatarController = TextEditingController(text: widget.post?.avatar ?? '');
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     bodyController.dispose();
//     nameController.dispose();
//     avatarController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (titleController.text.isEmpty || bodyController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text(
//             'Veuillez remplir au moins le titre et le contenu',
//           ),
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       );
//       return;
//     }

//     final post = Post(
//       id: widget.post!.id,
//       title: titleController.text,
//       body: bodyController.text,
//       name: nameController.text,
//       avatar: avatarController.text,
//       createdAt: widget.post?.createdAt ?? DateTime.now().toString(),
//     );

//     if (isEditing) {
//       context.read<PostBloc>().add(UpdatePost(post));
//     } else {
//       context.read<PostBloc>().add(AddPost(post));
//     }

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F9),
//       appBar: AppBar(
//         title: Text(isEditing ? 'Modifier le post' : 'Nouveau post'),
//         backgroundColor: const Color(0xFF6C63FF),
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Avatar preview
//             Center(
//               child: CircleAvatar(
//                 radius: 40,
//                 backgroundColor: const Color(0xFF6C63FF).withValues(alpha: 0.1),
//                 backgroundImage: avatarController.text.isNotEmpty
//                     ? NetworkImage(avatarController.text)
//                     : null,
//                 child: avatarController.text.isEmpty
//                     ? const Icon(
//                         Icons.person,
//                         size: 40,
//                         color: Color(0xFF6C63FF),
//                       )
//                     : null,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Name field
//             _buildTextField(
//               controller: nameController,
//               label: 'Nom',
//               icon: Icons.person_outline,
//             ),
//             const SizedBox(height: 16),

//             // Title field
//             _buildTextField(
//               controller: titleController,
//               label: 'Titre',
//               icon: Icons.title,
//             ),
//             const SizedBox(height: 16),

//             // Body field
//             _buildTextField(
//               controller: bodyController,
//               label: 'Contenu',
//               icon: Icons.description_outlined,
//               maxLines: 5,
//             ),
//             const SizedBox(height: 16),

//             // Avatar URL field
//             _buildTextField(
//               controller: avatarController,
//               label: 'Avatar URL',
//               icon: Icons.link,
//               onChanged: (_) => setState(() {}),
//             ),
//             const SizedBox(height: 32),

//             // Submit button
//             SizedBox(
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: _submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6C63FF),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   elevation: 3,
//                 ),
//                 child: Text(
//                   isEditing ? 'Enregistrer' : 'Publier',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     int maxLines = 1,
//     ValueChanged<String>? onChanged,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: Colors.grey.shade200),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//       ),
//     );
//   }
// }
