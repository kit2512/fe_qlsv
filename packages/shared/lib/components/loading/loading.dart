import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  startLoading(bool? isFirst, Rx<bool> isLoading) async {
    if (isFirst == true) {
      await Future.delayed(Duration.zero);
      isLoading.value = true;
      Get.dialog(
          const AlertDialog(
            content: CommonLoading(),
          ),
          barrierDismissible: false);
    }
  }

  endLoading(bool? isFirst, Rx<bool> isLoading) {
    if (isFirst == true) {
      isLoading.value = false;
      Get.back();
    }
  }
}

class CommonLoading extends StatefulWidget {
  const CommonLoading({super.key});

  @override
  State<CommonLoading> createState() => _CommonLoadingState();
}

class _CommonLoadingState extends State<CommonLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 456,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 100,
              height: 100,
              child: const CircularProgressIndicator()
          ),
          const SizedBox(height: 32),
          const Text(
            'Loading...',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'It will take a few seconds.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            )
          ),
        ],
      ),
    );
  }
}
