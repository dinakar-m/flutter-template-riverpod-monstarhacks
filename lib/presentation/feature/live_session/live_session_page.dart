import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../play_lecture/video_page.dart';

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "cadfae3db9754e12b9e826945e665f9d";
// Token expires on May 1, 2023 3:41 AM UTC
const agoraToken =
    "007eJxTYFgjqHVxgqVTx4++EpGDCtIvrJYcWBX07PrWm1Wuy2JnLsxSYEhOTElLTDVOSbI0NzVJNTRKsky1MDKzNDFNNTMzTbNMiXrsm9IQyMhQWPqPhZEBAkF8IYbE4oxE3ZzMstT4kqLEzLzMvHQGBgC1OSbH";
const channel = "asha-live_training";

class LiveSessionPage extends ConsumerStatefulWidget {
  const LiveSessionPage({Key? key}) : super(key: key);

  @override
  LiveSessionPageState createState() => LiveSessionPageState();
}

class LiveSessionPageState extends ConsumerState<LiveSessionPage> {
  List<int> _remoteUidList = [];
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    debugPrint('LiveSessionPage initState....');
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    debugPrint('LiveSessionPage leave channel from dispose');
    super.dispose();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(
              "LiveSessionPage local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("LiveSessionPage remote user $remoteUid joined");
          setState(() {
            _remoteUidList.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("LiveSessionPage remote user $remoteUid left channel");
          setState(() {
            _remoteUidList.remove(remoteUid);
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
            'LiveSessionPage [onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token',
          );
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.enableAudio();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: agoraToken,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Widget _buildAppBar() {
    final needRecording = _remoteUidList.isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Live Session'),
        TextButton(
          onPressed: () {
            debugPrint('Sync......');
          },
          child: Text(needRecording ? 'Recording' : 'Not Recording'),
        ),
      ],
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBar(),
      ),
      body: Column(
        children: [
          _buildLocalView(),
          const Text(
            'Participants',
            style: TextStyle(fontSize: 15),
          ),
          Expanded(child: _remoteVideo()),
        ],
      ),
    );
  }

  Widget _buildLocalView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: AspectRatio(
        aspectRatio: 3,
        child: _localUserJoined
            ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUidList.isEmpty) {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _remoteUidList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.primaries[index % 10],
          child: _buildRemoveSingleView(_remoteUidList[index]),
        );
      },
    );
  }

  Widget _buildRemoveSingleView(int _remoteUid) {
    if (_remoteUid == 0) {
      return Container();
    }
    debugPrint('_buildRemoveSingleView userid $_remoteUid');
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: _remoteUid),
        connection: const RtcConnection(channelId: channel),
      ),
    );
  }
}
