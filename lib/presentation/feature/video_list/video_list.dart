import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';

import 'package:flutter_template_riverpod/presentation/feature/play_lecture/video_page.dart';
import 'package:path_provider/path_provider.dart';

class VideoSection {
  VideoSection({required this.title, required this.thumbnails});

  String title;
  List<VideoThumbnail> thumbnails;
}

class VideoThumbnail {
  VideoThumbnail(
      {required this.title,
      required this.thumbnailUrl,
      required this.videoUrl});

  String title;
  String thumbnailUrl;
  String videoUrl;
}

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<File> videos = [];

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  void _getVideos() async {
    // Get the application directory
    final appDir = await getApplicationDocumentsDirectory();

    // Use the flutter_file_manager package to list the video files in the directory
    final files = await FileManager.listFiles(
      appDir.path,
      extensions: ['.mp4'],
    );

    // Convert the list of FileSystemEntity objects to a list of File objects
    setState(() {
      videos = files.map((f) => File(f.path)).toList();
    });
    debugPrint('Vide list files... $videos');
  }

  final List<VideoSection> videoSections = [
    VideoSection(
      title: 'Section 1',
      thumbnails: [
        VideoThumbnail(
            title: 'Video 1',
            thumbnailUrl: 'https://picsum.photos/id/1/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 2',
            thumbnailUrl: 'https://picsum.photos/id/2/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 3',
            thumbnailUrl: 'https://picsum.photos/id/3/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 4',
            thumbnailUrl: 'https://picsum.photos/id/4/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 5',
            thumbnailUrl: 'https://picsum.photos/id/5/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      ],
    ),
    VideoSection(
      title: 'Section 2',
      thumbnails: [
        VideoThumbnail(
            title: 'Video 1',
            thumbnailUrl: 'https://picsum.photos/id/1/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 2',
            thumbnailUrl: 'https://picsum.photos/id/2/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 3',
            thumbnailUrl: 'https://picsum.photos/id/3/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 4',
            thumbnailUrl: 'https://picsum.photos/id/4/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 5',
            thumbnailUrl: 'https://picsum.photos/id/5/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      ],
    ),
    VideoSection(
      title: 'Section 3',
      thumbnails: [
        VideoThumbnail(
            title: 'Video 1',
            thumbnailUrl: 'https://picsum.photos/id/1/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 2',
            thumbnailUrl: 'https://picsum.photos/id/2/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 3',
            thumbnailUrl: 'https://picsum.photos/id/3/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 4',
            thumbnailUrl: 'https://picsum.photos/id/4/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 5',
            thumbnailUrl: 'https://picsum.photos/id/5/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      ],
    ),
    VideoSection(
      title: 'Section 4',
      thumbnails: [
        VideoThumbnail(
            title: 'Video 1',
            thumbnailUrl: 'https://picsum.photos/id/1/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 2',
            thumbnailUrl: 'https://picsum.photos/id/2/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 3',
            thumbnailUrl: 'https://picsum.photos/id/3/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        VideoThumbnail(
            title: 'Video 4',
            thumbnailUrl: 'https://picsum.photos/id/4/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        VideoThumbnail(
            title: 'Video 5',
            thumbnailUrl: 'https://picsum.photos/id/5/200/300',
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBar(context),
      ),
      body: _buildNotSynchedVideosView(context),
    );
  }

  Widget _buildNotSynchedVideosView(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            height: 260,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 210,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/play_button.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    onTap: () {
                      final file = videos[index].path;
                      debugPrint('File......$file');
                      final route = MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => PlayLecturePage(filePath: file),
                      );
                      Navigator.push(context, route);
                    },
                  ),
                  Center(child: Text(basename(videos[index].path))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSynchedVideosView(BuildContext context) {
    return ListView.builder(
      itemCount: videoSections.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                videoSections[index].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videoSections[index].thumbnails.length,
                itemBuilder: (BuildContext context, int index2) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8),
                    child: GestureDetector(
                      onTap: () {
                        // Play video
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 160,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(videoSections[index]
                                    .thumbnails[index2]
                                    .thumbnailUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            videoSections[index].thumbnails[index2].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.video_list_page_title),
        TextButton(
          onPressed: () {
            debugPrint('Sync......');
          },
          child: Text(AppLocalizations.of(context)!.video_list_page_synch),
        ),
      ],
    );
  }
}
