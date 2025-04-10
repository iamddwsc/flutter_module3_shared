import 'dart:async';

/// A generic class that provides a communication channel between modules
class SharedObject<T> {
  // Stream controller to broadcast events to all listeners
  final _controller = StreamController<T>.broadcast();

  // Current value
  T? _value;

  /// Get the current value
  T? get value => _value;

  /// Stream of values that modules can listen to
  Stream<T> get stream => _controller.stream;

  /// Update the value and notify all listeners
  void update(T newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  /// Dispose the controller when no longer needed
  void dispose() {
    _controller.close();
  }
}

/// An example implementation for string messages
class SharedMessage extends SharedObject<String> {
  // You can add specific methods for this type of shared object
  void sendMessage(String message) {
    update(message);
  }
}

/// An example implementation for UI state changes
class SharedUIState extends SharedObject<Map<String, dynamic>> {
  // Initialize with empty state
  SharedUIState() {
    _value = {};
  }

  // Update a specific UI property
  void updateProperty(String propertyName, dynamic propertyValue) {
    final newState = Map<String, dynamic>.from(_value ?? {});
    newState[propertyName] = propertyValue;
    update(newState);
  }

  // Get a specific property value
  dynamic getProperty(String propertyName) {
    return _value?[propertyName];
  }
}
