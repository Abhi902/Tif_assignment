import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../blocs/bloc/event_bloc.dart';
import '../model/event_model.dart';

fetchData(Emitter<EventState> emit) async {
  final response = await http.get(
    Uri.parse('https://sde-007.api.assignment.theinternetfolks.works/v1/event'),
  );

  if (response.statusCode == 200) {
    log("fetching finished");

    final decodedData = json.decode(response.body);
    final event = Event.fromJson(decodedData);

    emit(EventFetched(events: event));
  } else {
    emit(EventNotFetched());
  }
}

searchEvent(String keyword, Emitter<EventState> emit) async {
  const baseUrl =
      "https://sde-007.api.assignment.theinternetfolks.works/v1/event";
  final modifiedUrl = "$baseUrl?search=$keyword";

  final response = await http.get(Uri.parse(modifiedUrl));

  emit(Searching());

  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body);
    final event = Event.fromJson(decodedData);

    if (event.content.data.length > 0) {
      emit(SearchCompleted(events: event));
    } else {
      emit(SearchFailed(message: "No Such Event"));
    }
    // Process the data as needed
    debugPrint(decodedData);
  } else {
    debugPrint('Error: ${response.statusCode}');
  }
}
