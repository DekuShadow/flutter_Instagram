part of 'app_bar_bloc.dart';

class AppBarState extends Equatable {
  @override
  List<Object?> get props => [];
}

// class LoadingDataState extends AppBarState {}
class AppBarInitial extends AppBarState {
  AppBarInitial();
  // final currentIndex;

  // AppBarInitial(this.currentIndex);
  // @override
  // List<Object> get props => [currentIndex];
}

class FollowerFinishState extends AppBarState {
  var userData = {};
  int postLen;
  int followers;
  int following;
  bool isFollowing = false;

  FollowerFinishState(
      {required this.userData,
      required this.postLen,
      required this.followers,
      required this.following,
      required this.isFollowing});

  @override
  List<Object> get props => [postLen, followers, following, isFollowing];
}
