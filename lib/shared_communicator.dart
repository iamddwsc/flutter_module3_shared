import 'package:flutter_module3_shared/shared_object.dart';

/// Singleton class to manage all shared objects
class SharedCommunicator {
  // Singleton instance
  static final SharedCommunicator _instance = SharedCommunicator._internal();

  // Factory constructor
  factory SharedCommunicator() => _instance;

  // Internal constructor
  SharedCommunicator._internal();

  // Store different shared objects
  final Map<String, dynamic> _objects = {};

  // Register a shared object with a key
  void register<T>(String key, SharedObject<T> object) {
    _objects[key] = object;
  }

  // Get a registered shared object by key and type
  T? get<T>(String key) {
    final obj = _objects[key];
    if (obj is T) {
      return obj;
    }
    return null;
  }

  // Dispose all objects when app is terminated
  void dispose() {
    _objects.forEach((key, object) {
      if (object is SharedObject) {
        object.dispose();
      }
    });
    _objects.clear();
  }
}
