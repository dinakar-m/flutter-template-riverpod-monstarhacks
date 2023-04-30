import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/routes.dart';
import '../../../common/user_manager.dart';
import '../../../common_widgets/space_box.dart';

const double leadingWidth = 100;

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.lightBlue,
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: false,
      leading: buildLeftContent(context),
      centerTitle: true,
      title: buildTitle(context),
      actions: buildActions(context),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }

  Widget buildLeftContent(BuildContext context) {
    return const SpaceBox();
  }

  Widget buildTitle(BuildContext context) {
    return const Text('Asha Health Explorer');
  }

  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      TextButton(
        onPressed: () => {
          context.pushNamed(
            RouteNames.liveSessionScreen,
          )
        },
        child: const Text(
          'LiveSession',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      TextButton(
        onPressed: () => {
          UserManager.logout().then(
            (value) => {
              doLogout(context),
            },
          ),
        },
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void doLogout(BuildContext context) {
    try {
      Navigator.of(context)
          .popUntil(ModalRoute.withName(RouteNames.homeScreen));
    } catch (e) {
      // TODO: handle exception, for example by showing an alert to the user
    }
    context.pushNamed(RouteNames.loginScreen);
  }
}
