import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_bar_event.dart';
part 'app_bar_state.dart';

class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(AppBarInitial()) {
    on<followerEvent>((event, emit) async {
      // emit(LoadingDataState());
      try {
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(event.uid)
            .get();

        // get post length
        var postSnap = await FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: event.uid)
            .get();
        var postLen = postSnap.docs.length;
        var userData = userSnap.data()!;
        var followers = userSnap.data()!['follower'].length;
        var following = userSnap.data()!['following'].length;
        var isFollowing = userSnap
            .data()!['follower']
            .contains(FirebaseAuth.instance.currentUser!.uid);

        emit(FollowerFinishState(
            postLen: postLen,
            followers: followers,
            following: following,
            isFollowing: isFollowing,
            userData: userData));
      } catch (e) {
        // showSnackBar(e.toString(), context);
      }
    });
  }
}
