// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/entities/post.dart';
// import '../bloc/post_bloc.dart';
// import '../bloc/post_event.dart';
// import '../bloc/post_state.dart';
// import 'post_form_screen.dart';

// class PostsListScreen extends StatefulWidget {
//   const PostsListScreen({super.key});

//   @override
//   State<PostsListScreen> createState() => _PostsListScreenState();
// }

// class _PostsListScreenState extends State<PostsListScreen> {
//   String _searchQuery = '';
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<PostBloc>().add(LoadPosts());
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   List<Post> _filterPosts(List<Post> posts) {
//     if (_searchQuery.isEmpty) return posts;
//     return posts.where((post) {
//       return post.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//           post.body.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//           post.name.toLowerCase().contains(_searchQuery.toLowerCase());
//     }).toList();
//   }

//   // String _formatDate(DateTime? date) {
//   //   if (date == null) return '';
//   //   try {
//   //     final now = DateTime.now();
//   //     final diff = now.difference(date);
//   //     if (diff.inMinutes < 1) return "À l'instant";
//   //     if (diff.inHours < 1) return "Il y a ${diff.inMinutes} min";
//   //     if (diff.inDays < 1) return "Il y a ${diff.inHours}h";
//   //     if (diff.inDays < 7) return "Il y a ${diff.inDays}j";
//   //     return "${date.day}/${date.month}/${date.year}";
//   //   } catch (_) {
//   //     return '';
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F9),
//       appBar: AppBar(
//         title: const Text("Posts"),
//         backgroundColor: const Color(0xFF6C63FF),
//         foregroundColor: Colors.white,
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(56),
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//             child: TextField(
//               controller: _searchController,
//               style: const TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Rechercher...',
//                 hintStyle: TextStyle(
//                   color: Colors.white.withValues(alpha: 0.7),
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.white.withValues(alpha: 0.7),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white.withValues(alpha: 0.2),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           if (state is PostLoading) {
//             return const Center(
//               child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
//             );
//           }

//           if (state is PostError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.message,
//                     style: TextStyle(color: Colors.grey[600], fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () => context.read<PostBloc>().add(LoadPosts()),
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Réessayer'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6C63FF),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is PostLoaded) {
//             final filteredPosts = _filterPosts(state.posts);

//             if (filteredPosts.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.article_outlined,
//                       size: 64,
//                       color: Colors.grey[300],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       _searchQuery.isNotEmpty
//                           ? 'Aucun post trouvé'
//                           : 'Aucun post disponible',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: filteredPosts.length,
//               itemBuilder: (context, index) {
//                 return _buildPostCard(context, filteredPosts[index]);
//               },
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const PostFormScreen()),
//           );
//         },
//         backgroundColor: const Color(0xFF6C63FF),
//         foregroundColor: Colors.white,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildPostCard(BuildContext context, Post post) {
//     return Dismissible(
//       key: Key('post_${post.id}'),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.red[400],
//           borderRadius: BorderRadius.circular(16),
//         ),
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 24),
//         child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
//       ),
//       confirmDismiss: (direction) async {
//         return await showDialog<bool>(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             title: const Text('Supprimer le post'),
//             content: Text('Voulez-vous vraiment supprimer "${post.title}" ?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(ctx, false),
//                 child: Text(
//                   'Annuler',
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(ctx, true),
//                 style: TextButton.styleFrom(foregroundColor: Colors.red),
//                 child: const Text('Supprimer'),
//               ),
//             ],
//           ),
//         );
//       },
//       onDismissed: (direction) {
//         context.read<PostBloc>().add(DeletePost(post.id));
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('"${post.title}" supprimé'),
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.only(bottom: 12),
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         clipBehavior: Clip.antiAlias,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => PostFormScreen(post: post)),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header: avatar + name + date
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage(post.avatar),
//                       onBackgroundImageError: (_, e) {},
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             post.name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Color(0xFF2D3142),
//                             ),
//                           ),
//                           // Text(
//                           //   _formatDate(post.createdAt.toString() as DateTime?),
//                           //   style: TextStyle(
//                           //     color: Colors.grey[400],
//                           //     fontSize: 12,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),

//                 // Title
//                 Text(
//                   post.title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2D3142),
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),

//                 // Body
//                 Text(
//                   post.body,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     height: 1.5,
//                   ),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
