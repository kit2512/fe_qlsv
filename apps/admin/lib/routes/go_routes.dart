import 'package:admin/features/facculty_details/bindings.dart';
import 'package:admin/features/facculty_details/facluty_details_page.dart';
import 'package:admin/features/features.dart';
import 'package:admin/middleware/auth_middleware.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class GoRoutes {
  static String get facultyDetails => "/faculties/:id";

  static String get createLecturer => "/lecturers/create";

  static String get editFaculty => "/faculties/edit/:id";

  static String get createFaculty => "/faculties/create";

  static String get classes => "/classes";

  static String get lecturers => "/lecturers";

  static String get lecturerDetails => "/lecturers/:id";

  static String get editLecturer => "/lecturers/edit";

  static String get profile => "/profile";

  static String get students => "/students";

  static String get home => "/";

  static String get addStudent => "/students/add";

  static String get login => "/login";

  static String get faculties => "/faculties";

  static String get subjects => "/subjects";

  static String get subjectDetails => "/subjects/:id";

  static String get editSubject => "/subjects/edit/:id";

  static String get createSubject => "/subjects/create";

  static String get subjectClasses => "/classes";

  static String get subjectClassDetails => "/classes/:id";

  static String get editSubjectClass => "/classes/edit/:id";

  static var params = {}.obs;
  static Rx<Object?> extra = Rx<Object?>(null);
  static var pathParameters = {}.obs;

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
        pathParameters.addAll(state.pathParameters);

        params.addAll(state.queryParameters);
        if (state.extra != null) {
          extra.value = state.extra;
        }
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      routes: routes,
    );
  }

  static final GoRouter router = GoRouter(
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
                  route: faculties,
                  iconData: Icons.departure_board_rounded,
                  label: "Faculties"),
              NavigationItem(
                route: subjects,
                iconData: Icons.subject_rounded,
                label: "Subjects",
              ),
              NavigationItem(
                route: subjectClasses,
                iconData: Icons.class_rounded,
                label: "Classes",
              ),
              NavigationItem(
                route: lecturers,
                iconData: Icons.account_box_rounded,
                label: "Lecturers",
              ),
            ],
            content: child,
            selectedRoute: state.location,
          );
        },
        routes: [
          commonRoute(
            useMiddleWare: true,
            path: home,
            bindings: HomeBindings(),
            page: const HomePage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: students,
            bindings: StudentsBindings(),
            page: const StudentPage(),
            routes: [],
          ),

          commonRoute(
            useMiddleWare: true,
            path: addStudent,
            bindings: AddStudentBindings(),
            page: const AddStudentPage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: faculties,
            bindings: FacultiesBindings(),
            page: const FacultiesPage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: createFaculty,
            bindings: CreateFacultyBindings(),
            page: const CreateFacultyPage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: editFaculty,
            bindings: EditFacultyBinding(),
            page: EditFacultyPage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: subjects,
            bindings: SubjectsBindings(),
            page: const SubjectsPage(),
            routes: [],
          ),
          commonRoute(
            useMiddleWare: true,
            path: createSubject,
            bindings: CreateSubjectBindings(),
            page: const CreateSubjectPage(),
            routes: [],
          ),
          commonRoute(
            path: subjectDetails,
            bindings: SubjectDetailsBindings(),
            page: SubjectDetailsPage(),
            routes: [],
          ),
          commonRoute(
            path: editSubject,
            bindings: EditSubjectBindings(),
            page: const EditSubjectPage(),
            routes: [],
          ),
          commonRoute(
            path: subjectClasses,
            bindings: SubjectClassesBindings(),
            page: SubjectClassesPage(),
            routes: [],
          ),
          commonRoute(
            path: subjectClassDetails,
            bindings: SubjectClassDetailsBinding(),
            page: SubjectClassesPage(),
            routes: [],
          ),
          commonRoute(
            path: lecturers,
            bindings: LecturersBindings(),
            page: LecturersPage(),
            routes: [],
          ),
          commonRoute(
            path: editLecturer,
            bindings: EditLecturerBindings(),
            page: const EditLecturePage(),
            routes: [],
          ),
          commonRoute(
            path: facultyDetails,
            bindings: FacultyDetailsBindings(),
            page: const FacultyDetailsPage(),
            routes: [],
          ),
        ],
      ),
      commonRoute(
        useMiddleWare: false,
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