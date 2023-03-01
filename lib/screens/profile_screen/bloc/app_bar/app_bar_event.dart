part of 'app_bar_bloc.dart';

abstract class AppBarEvent extends Equatable {
  const AppBarEvent();

  @override
  List<Object> get props => [];
}

class followerEvent extends AppBarEvent {
  final uid;

  const followerEvent({this.uid});
}
