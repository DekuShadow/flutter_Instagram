part of 'app_bar_bloc.dart';

abstract class AppBarState extends Equatable {
  const AppBarState();
  @override
  List<Object?> get props => [];
}

class LoadingDataState extends AppBarState {}

class AppBarInitial extends AppBarState {
  final currentIndex;

  AppBarInitial(this.currentIndex);
  @override
  List<Object> get props => [currentIndex];
}

class FollowerFinishState extends AppBarState {
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;

  @override
  List<Object> get props => [postLen, followers, following, isFollowing];
}
