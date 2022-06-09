import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/comments_page.dart';
import 'package:photo_gallery/photo.dart';
import 'package:photo_gallery/photo_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (context) {
        if (currentindex == 1) {
          return const Coment();
        }
        return FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return PhotosList(photos: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          onTap: (newIndex) {
            setState(() {
              currentindex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_double_arrow_left_rounded),
                label: 'Photo Gallery'),
            BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_double_arrow_right_outlined),
                label: 'Comments list'),
          ]),
    );
  }
}
