import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../model/event_model.dart';
import '../../services/services.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<FetchDetailsStart>((event, emit) async {
      return await fetchData(emit);
    });

    on<SearchEventTriggered>((event, emit) async {
      return await searchEvent(event.searchString, emit);
    });
    _startAutoEvent();
  }
  void _startAutoEvent() {
    add(FetchDetailsStart());
  }
}
