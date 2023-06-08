import 'package:flutter_flavor/flutter_flavor.dart';

import 'local_flavor.dart';
import 'production_flavor.dart';

abstract class AppFlavor {
  static AppFlavor? _current;


  static AppFlavor get current {
    if (_current == null) {
      throw 'Exception: Must call init';
    }
    return _current!;
  }

  static init(String name) {
    if (name == "local") {
      _current = LocalFlavor();
    }
    if (name == "production") {
      _current = ProductionFlavor();
    }
  }

  abstract FlavorConfig admin;

  abstract FlavorConfig student;

  abstract FlavorConfig lecturer;

  abstract FlavorConfig console;
}
