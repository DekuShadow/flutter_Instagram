import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'web_screen_event.dart';
part 'web_screen_state.dart';

class WebScreenBloc extends Bloc<WebScreenEvent, WebScreenState> {
  WebScreenBloc() : super(WebScreenInitial()) {
    on<WebScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
