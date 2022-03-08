import 'package:carespot/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc homeBloc;
  final String uid;

  const HomeBlocProvider(Key? key,
      {required Widget child, required this.homeBloc, required this.uid})
      : super(key: key, child: child);

  static HomeBlocProvider? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<HomeBlocProvider>());
  }

  @override
  bool updateShouldNotify(HomeBlocProvider oldWidget) =>
      homeBloc != oldWidget.homeBloc;
}
