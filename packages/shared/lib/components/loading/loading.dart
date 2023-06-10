import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  RxBool isLoading = false.obs;
  startLoading() async {
    isLoading.value = true;
  }

  endLoading() {
    isLoading.value = false;
  }
}

class CommonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 456,
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(32.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
            SizedBox(height: 32),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Text('It will take a few seconds.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }
}
