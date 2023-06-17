import 'package:flutter/material.dart';
import '../server/network_caller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostsAPI _postsAPI = PostsAPI();
  final ScrollController _scrollController = ScrollController();
  final List<dynamic> _posts = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchPosts() async {
    if (_isFetching) return;

    setState(() {
      _isFetching = true;
    });

    final fetchedPosts = await _postsAPI.fetchPosts();

    setState(() {
      _posts.addAll(fetchedPosts);
      _isFetching = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final postIndex = (index ~/ 2);
          final post = _posts[postIndex];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(child: Text(post['id'].toString())),
                title: Text(post['title']),
                subtitle: Text(post['body']),
              ),
            ],
          );
        },
      ),
    );
  }
}
