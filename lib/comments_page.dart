import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load informiation');
  }
}

class Album {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Album({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      postId: json['postId'],
      id: json['id'],
      name: json['title'],
      email: json['email'],
      body: json['body'],
    );
  }

  String get title => title;
}

void main() => runApp(const Coment());

class Coment extends StatefulWidget {
  const Coment({super.key});

  @override
  _ComentState createState() => _ComentState();
}

class _ComentState extends State<Coment> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
