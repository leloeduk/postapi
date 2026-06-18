import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leloapp/features/posts/data/repositories/post_repository_impl.dart';
import 'package:leloapp/features/posts/data/services/post_api_service.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_bloc.dart';
import 'package:leloapp/features/posts/presentation/bloc/post_event.dart';
import 'features/posts/presentation/pages/post_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(
      PostApiService(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PostBloc(postRepositoryImpl)..add(LoadedPostEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const PostListPage(),
      ),
    );
  }
}
