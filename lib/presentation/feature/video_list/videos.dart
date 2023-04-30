import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider/path_provider.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  List<File> videos = [];

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  void _getVideos() async {
    // Get the application directory
    final  appDir = await getApplicationDocumentsDirectory();

    // Use the flutter_file_manager package to list the video files in the directory
    final files =
    await FileManager.listFiles(
        appDir.path,
        extensions: ['mp4', 'avi', 'wmv', 'mov']
    );

    // Convert the list of FileSystemEntity objects to a list of File objects
    setState(() {
      videos = files.map((f) => File(f.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(videos[index].path),
          onTap: () {
            // Play the video
          },
        );
      },
    );
  }
}


