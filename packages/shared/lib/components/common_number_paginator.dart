import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared/constants/colors.dart';

class CommonNumberPaginator extends StatelessWidget {
  const CommonNumberPaginator({super.key});

  @override
  Widget build(BuildContext context) {
    return const NumberPaginator(
      numberPages: 20,
      config: NumberPaginatorUIConfig(
        mode: ContentDisplayMode.numbers,
        // contentPadding: const EdgeInsets.all(12.0),
        buttonShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        buttonSelectedBackgroundColor: AppColors.primary,
        buttonSelectedForegroundColor: Colors.white,
        buttonUnselectedForegroundColor: AppColors.primary,
        buttonUnselectedBackgroundColor: Colors.transparent,
      ),
    );
  }
}
