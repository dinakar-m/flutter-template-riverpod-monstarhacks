import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/resources/colors.dart';
import '../../../constants/routes.dart';
import '../../common/user_manager.dart';
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
  bool isLecturerLoggedIn = false;

  List _screens = [];

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
  void initState() {
    super.initState();
    _screens = [
      const VideoList(),
      const ChatPage(),
      const LiveSessionPage(),
      if (isLecturerLoggedIn) const RecordLecturePage(),
    ];
    Future.delayed(const Duration(milliseconds: 500), () {
      UserManager.isLecturerLoggedIn().then(
        (value) => {
          setState(() {
            isLecturerLoggedIn = value;
            _screens = [
              const VideoList(),
              const ChatPage(),
              const LiveSessionPage(),
              if (isLecturerLoggedIn) const RecordLecturePage(),
            ];
          }),
        },
      );
      UserManager.isLoggedIn().then(
        (value) => {
          // logged in
          if (!value)
            {
              debugPrint('login page logged in '),
              context.pushNamed(RouteNames.loginScreen),
              // Navigator.of(context).pop(),
            }
        },
      );
    });
    // context.pushNamed(RouteNames.loginScreen);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: context.colors.background,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.colors.background,
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
              icon: const Icon(Icons.video_collection_outlined),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.home_chat,
              icon: const Icon(Icons.chat_outlined),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.home_tab_live_session,
              icon: const Icon(Icons.video_call),
            ),
            if (isLecturerLoggedIn)
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.home_record_lecture,
                icon: const Icon(Icons.video_camera_back_rounded),
              ),
          ],
        ),
      ),
    );
  }
}
