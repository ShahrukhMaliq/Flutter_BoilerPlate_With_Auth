import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/application/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  AppLifecycleObserver({Key? key, required this.child}) : super(key: key);

  @override
  _AppLifecycleObserver createState() => _AppLifecycleObserver();
}

class _AppLifecycleObserver extends State<AppLifecycleObserver> with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_lastLifecycleState);
    context.read<ApplicationBloc>().add(AppLifecycleChangedEvent(_lastLifecycleState!));

    return Container(child: widget.child);
  }
}
