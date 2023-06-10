import 'package:flutter_flavor/flutter_flavor.dart';

import 'base_flavor.dart';

class ProductionFlavor implements AppFlavor {
  @override
  FlavorConfig admin = FlavorConfig(variables: {
    "mode": "production",
    "uri": "https://fe-qlsv.web.app/#",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": false,
  });

  @override
  FlavorConfig student = FlavorConfig(variables: {
    "mode": "production",
    "uri": "http://localhost.qlsv.io:8081",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": false,
  });
  @override
  FlavorConfig lecturer = FlavorConfig(variables: {
    "mode": "production",
    "uri": "http://localhost.qlsv.io:8082",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": false,
  });

  @override
  FlavorConfig console = FlavorConfig(variables: {
    "mode": "production",
    "uri": "http://localhost.qlsv.io:8082",
    "baseUrl": "https://kma-apis.hvg.id.vn/",
    "logging": false,
  });
}
