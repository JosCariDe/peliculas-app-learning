import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).asyncExpand(mapper);
}