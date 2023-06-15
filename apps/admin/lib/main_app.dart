import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/src/navigation_non_web/url_strategy.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared/shared.dart';

void runMain() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}

Future<void> initDependencies() async {
  final logging = AppFlavor.current.admin.variables["logging"] ?? false;
  Get.put<Logger>(Logger(level: logging ? Level.verbose : Level.nothing),
      permanent: true);
  Get.put<LocalStorageModule>(
    SharedPrefLocalStorageImpl(),
    permanent: true,
  );
  Get.put<RestfulModule>(
    RestfulModuleDioImpl(
      localStorageModule: Get.find<LocalStorageModule>(),
    ),
  );
  Get.put<LoadingController>(LoadingController(), permanent: true);
  Get.put<UserService>(
    UserService(
      restfulModule: Get.find<RestfulModule>(),
      localStorageModule: Get.find<LocalStorageModule>(),
    ),
  );

  Get.put<UserRepository>(UserRepository(restfulModule: Get.find()),
      permanent: true);

  Get.put<FacultyRepository>(FacultyRepository(), permanent: true);

  Get.put<StudentRepository>(StudentRepository(), permanent: true);

  Get.put<MajorRepository>(MajorRepository(), permanent: true);

  Get.put<SubjectRepository>(SubjectRepository(), permanent: true);

  Get.put<LecturerRepository>(LecturerRepository(), permanent: true);

  Get.put<SubjectClassRepository>(SubjectClassRepository(), permanent: true);

  AdaptiveLayout.setBreakpoints(
    mediumScreenMinWidth: MediaQueryBreakpoints.small,
    largeScreenMinWidth: MediaQueryBreakpoints.medium,
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "HiSchool Admin",
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      theme: appTheme,
      routerConfig: GoRoutes.router,
    );
  }
}
