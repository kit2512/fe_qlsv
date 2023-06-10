import 'package:flutter_flavor/flutter_flavor.dart';

import 'base_flavor.dart';

class LocalFlavor implements AppFlavor {
  @override
  FlavorConfig admin = FlavorConfig(variables: {
    "mode": "dev",
    "uri": "http://localhost.qlsv.com:8080/#",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": true,
  });

  @override
  FlavorConfig student = FlavorConfig(variables: {
    "mode": "dev",
    "uri": "http://localhost.qlsv.io:8081",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": true,
  });
  @override
  FlavorConfig lecturer = FlavorConfig(variables: {
    "mode": "dev",
    "uri": "http://localhost.qlsv.io:8082",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": true,
  });

  @override
  FlavorConfig console = FlavorConfig(variables: {
    "mode": "dev",
    "uri": "http://localhost.qlsv.io:8083",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": true,
  });
}
