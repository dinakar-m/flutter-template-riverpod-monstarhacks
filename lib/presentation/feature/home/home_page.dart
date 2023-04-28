import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/resources/colors.dart';
import '../../common_widgets/base/base_page.dart';
import '../chat/chat_page.dart';
import '../live_session/live_session_page.dart';
import '../record_lecture/record_lecture_page.dart';
import '../video_list/video_list.dart';
import 'widgets/home_app_bar.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  BasePageState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List _screens = [
    const VideoList(),
    const RecordLecturePage(),
    const LiveSessionPage(),
    const ChatPage(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const HomeAppBar();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: context.colors.mediumBlue,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.home_tab_video_list,
            icon: const Icon(Icons.newspaper),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.home_tab_top_anime,
            icon: const Icon(Icons.newspaper),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.home_tab_live_session,
            icon: const Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.home_tab_profile,
            icon: const Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}
