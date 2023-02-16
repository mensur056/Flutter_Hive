import 'package:flutter_hive/service/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICacheManager<T> {
  final String key;
  Box<UserModel>? _box;
  ICacheManager(this.key);
  Future<void> init() async {
    if (!(_box?.isOpen ?? true)) {
      _box = await Hive.openBox(key);
    }
  }

  Future<void> clearAll(String key) async {
    await _box?.clear();
  }

  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  T? getItem(String key);
  Future<void> putItem(String key, T item);
  Future<void> removeItem(String key) async {
    await _box?.clear();
  }
}

class GeneralCacheManager extends ICacheManager<UserModel> {
  GeneralCacheManager(super.key);

  @override
  Future<void> addItems(List<UserModel> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> putItems(List<UserModel> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  @override
  UserModel? getItem(String key) {
    return _box?.get(key);
  }

  @override
  Future<void> putItem(String key, item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> removeItem(String key) async {
    await _box?.delete(key);
  }
}
