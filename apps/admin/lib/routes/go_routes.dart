import 'package:admin/features/add_student/add_students.dart';
import 'package:admin/features/login/bindings/login_bindings.dart';
import 'package:admin/features/login/login_page.dart';
import 'package:admin/features/students/binding.dart';
import 'package:admin/features/students/students_page.dart';
import 'package:admin/middleware/auth_middleware.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/components/common_main_page.dart';

class GoRoutes {
  static String get classes => "/classes";

  static String get lecturers => "/lecturers";

  static String get profile => "/profile";

  static String get students => "/students";

  static String get home => "/";

  static String get addStudent => "/students/add";
  static String get login => "/login";

  static var params = {}.obs;
  static var extra = {}.obs;

  static commonRoute({
    required String path,
    required Bindings bindings,
    required Widget page,
    bool? useMiddleWare = true,
    required List<RouteBase> routes,
  }) {
    return GoRoute(
        path: path,
        name: path,
        pageBuilder: (context, state) {
          if (useMiddleWare!) {
            var auth = AuthMiddleware(userService: Get.find());
            auth.redirect(null);
          }
          bindings.dependencies();
          params.addAll(state.queryParameters);
          if (state.extra != null) {
            extra.assignAll(state.extra as Map<dynamic, dynamic>);
          }
          return CustomTransitionPage(
            key: state.pageKey,
            child: page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.linear).animate(animation),
                child: child,
              );
            },
          );
        },
        builder: (context, state) {
          bindings.dependencies();
          params.assignAll(state.queryParameters);
          return page;
        },
        routes: routes);
  }

  static final GoRouter router = GoRouter(
    initialLocation: home,
    navigatorKey: Get.key,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          LoginBindings().dependencies();
          return CommonMainPage(
            navigationItems: [
              NavigationItem(
                route: students,
                iconData: Icons.home,
                label: "Students",
                queryParameters: {},
              ),
              NavigationItem(
                route: profile,
                iconData: Icons.person,
                label: "Profile",
                queryParameters: {},
              ),
            ],
            content: child,
            selectedRoute: state.location,
          );
        },
        routes: [
          commonRoute(
            path: home,
            bindings: HomeBindings(),
            page: const HomePage(),
            routes: [],
          ),
          commonRoute(
            path: students,
            bindings: StudentsBindings(),
            page: const StudentPage(),
            routes: [],
          ),
          commonRoute(
            path: profile,
            bindings: ProfileBindings(),
            page: const ProfilePage(),
            routes: [],
          ),
          commonRoute(
            path: addStudent,
            bindings: AddStudentBindings(),
            page: const AddStudentPage(),
            routes: [],
          ),
        ],
      ),
      commonRoute(
        path: login,
        bindings: LoginBindings(),
        page: const LoginPage(),
        routes: [],
      )
    ],
  );
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home page"),
    );
  }
}

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}

class ProfileController extends GetxController {}

class ProfilePage extends GetView<ProfilePage> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Profile page");
  }
}
