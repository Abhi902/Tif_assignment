// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_bloc.dart';

@immutable
abstract class EventEvent extends Equatable {}

class FetchDetailsStart extends EventEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchEventTriggered extends EventEvent {
  final String searchString;
  SearchEventTriggered({
    required this.searchString,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}
