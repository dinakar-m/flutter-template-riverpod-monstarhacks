import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/routes.dart';
import '../../presentation/common/user_manager.dart';
import '../../presentation/feature/home/home_page.dart';
import '../../presentation/feature/login/login_page.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter goRouter(ref) => GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: 
                   RoutePaths.root,

          //  UserManager.isLoggedIn1() ? RouteNames.homeScreen : RoutePaths.root,
          builder: (context, state) {
                        return const HomePage();

            // return UserManager.isLoggedIn1() ?  const HomePage() : LoginPage();
          },
          routes: [
            GoRoute(
              name: RouteNames.loginScreen,
              builder: (context, state) {
                return LoginPage();
              },
              path: RouteNames.loginScreen,
            ),
            GoRoute(
              name: RouteNames.homeScreen,
              builder: (context, state) {
                return const HomePage();
              },
              path: RouteNames.homeScreen,
            ),
           
          ],
        ),
      ],
    );
