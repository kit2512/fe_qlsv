import 'package:flutter/material.dart';

class CommonContentPage extends StatefulWidget {
  const CommonContentPage({
    super.key,
    required this.content,
    this.onInit,
    this.floatingActionButton,
  });

  final Function? onInit;

  final Widget content;
  final Widget? floatingActionButton;

  @override
  State<CommonContentPage> createState() => _CommonContentPageState();
}

class _CommonContentPageState extends State<CommonContentPage> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit!();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.content,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
