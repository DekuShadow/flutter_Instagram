part of 'app_bar_bloc.dart';

abstract class AppBarEvent extends Equatable {
  const AppBarEvent();

  @override
  List<Object> get props => [];
}

class IndexcurrentEvent extends AppBarEvent {
  final currentIndex;
  IndexcurrentEvent(this.currentIndex);
}

class followerEvent extends AppBarEvent {
  final uid;

  followerEvent(this.uid);
}
