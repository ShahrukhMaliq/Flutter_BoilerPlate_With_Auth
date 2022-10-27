import 'dart:async';
import 'dart:ui';

/// Globally accessible AuthenticationContext.
class AppLifecycleContext {
  static final AppLifecycleContext _instance = AppLifecycleContext._internal();

  factory AppLifecycleContext() => _instance;

  AppLifecycleContext._internal();

  final _controller = StreamController<AppLifecycleState>();

  Stream<AppLifecycleState> get status async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    yield* _controller.stream;
  }

  add(AppLifecycleState state) {
    _controller.add(state);
  }

  void dispose() => _controller.close();
}
