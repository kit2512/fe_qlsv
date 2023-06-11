import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class NavigationItem {
  final String route;
  final IconData iconData;
  final String label;
  final Map<String, dynamic>? queryParameters;

  const NavigationItem({
    required this.route,
    required this.iconData,
    required this.label,
    this.queryParameters,
  });
}

class CommonMainPage extends GetView<LoadingController> {
  final List<NavigationItem> navigationItems;
  final Widget content;
  final String selectedRoute;
  final Widget? floatingActionButton;
  final Function? onInit;

  const CommonMainPage({
    super.key,
    required this.navigationItems,
    required this.content,
    this.floatingActionButton,
    required this.selectedRoute,
    this.onInit,
  });

  Widget buildContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdaptiveLayout(
        smallLayout: Drawer(
          backgroundColor: Colors.white,
          child: buildMenus(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const CommonAppBar(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildSideBar(),
                    AdaptiveLayout(
                      largeLayout: const VerticalDivider(),
                      mediumLayout: const SizedBox.shrink(),
                    ),
                    Expanded(
                      child: buildContent(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(seconds: 5),
            child: Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Material(
                        color: Colors.black.withOpacity(0.5),
                        child: const CommonLoading(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget buildSideBar() {
    return AdaptiveLayout(
      mediumLayout: const SizedBox.shrink(),
      smallLayout: const SizedBox.shrink(),
      largeLayout: SizedBox(
        width: 200.0,
        child: buildMenus(),
      ),
    );
  }

  Widget buildMenus() {
    return Column(
      children: [
        AdaptiveLayout(
          largeLayout: const SizedBox.shrink(),
          mediumLayout: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Menu", style: AppTextTheme.pageTitleTheme),
                  IconButton(
                    onPressed: Scaffold.of(context).closeDrawer,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: navigationItems.length,
            itemBuilder: (context, index) {
              final navItem = navigationItems[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                selected: selectedRoute == navItem.route,
                selectedTileColor: AppColors.primary.withOpacity(0.1),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  context.goNamed(navItem.route,
                      queryParameters: navItem.queryParameters == null
                          ? {}
                          : navItem.queryParameters!);
                },
                leading: Icon(
                  navItem.iconData,
                  color:
                      selectedRoute == navItem.route ? AppColors.primary : null,
                ),
                title: Text(
                  navItem.label,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: selectedRoute == navItem.route
                          ? AppColors.primary
                          : null,
                      fontWeight: selectedRoute == navItem.route
                          ? FontWeight.bold
                          : null),
                ),
              );
            },
          ),
        ),
        InkWell(
          onTap: () async {
            final result = await Get.dialog(
              AlertDialog(
                title: const Text("Log out"),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: const Text("Log out"),
                  ),
                ],
              )
            );
            if (result == true) {
              final userService = Get.find<UserService>();
              userService.logout();
            }

          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.logout_rounded),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text("Log out"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    IconButton buildDrawerButton() {
      return IconButton(
        icon: const Icon(
          Icons.menu_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }

    return Container(
      color: AppColors.primary,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AdaptiveLayout(
            mediumLayout: buildDrawerButton(),
            largeLayout: const SizedBox.shrink(),
          ),
          const SizedBox(
            width: 16.0,
          ),
          const Text(
            "HiSchool Management System",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
