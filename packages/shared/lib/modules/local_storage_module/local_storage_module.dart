abstract class LocalStorageModule {
  Future<void> set<T>(String key, T value);
  Future<void> remove<T>(String key);
  Future<T?> get<T>(String key);
  Future<void> clear();
}
