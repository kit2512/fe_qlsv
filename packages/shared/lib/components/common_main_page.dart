import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/constants/constants.dart';
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          drawer: AdaptiveLayout(
            smallLayout: Drawer(
              backgroundColor: Colors.white,
              child: buildMenus(),
            ),
          ),
          body: Column(
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
                    Expanded(child: buildContent()),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: floatingActionButton,
        ),
        Obx(
          () => controller.isLoading.value ? Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.black.withOpacity(0.5),
              child: CommonLoading(),
            ),
          ) : const SizedBox.shrink(),
        )
      ],
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
            builder: (context) => GestureDetector(
              onTap: Scaffold.of(context).closeDrawer,
              child: const SizedBox(
                height: 60.0,
                child: Row(
                  children: [
                    Icon(Icons.close),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Close"),
                  ],
                ),
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
                onTap: () {
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
        GestureDetector(
          onTap: () {
            // TODO: Handle log out
          },
          child: const SizedBox(
            height: 60.0,
            child: Row(
              children: [
                Icon(Icons.login_rounded),
                SizedBox(
                  width: 12,
                ),
                Text("Log out"),
              ],
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
            smallLayout: buildDrawerButton(),
            mediumLayout: buildDrawerButton(),
            largeLayout: const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
