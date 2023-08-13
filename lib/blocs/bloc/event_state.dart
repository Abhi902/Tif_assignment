// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

@immutable
abstract class EventState extends Equatable {}

class EventInitial extends EventState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EventFetched extends EventState {
  final Event events;
  EventFetched({
    required this.events,
  });
  @override
  List<Object?> get props => [events];
}

class EventNotFetched extends EventState {
  final String message = "No Internet";
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class Searching extends EventState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SearchCompleted extends EventState {
  final Event events;
  SearchCompleted({
    required this.events,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SearchFailed extends EventState {
  final String message;
  SearchFailed({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
