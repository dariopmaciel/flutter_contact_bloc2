import 'package:freezed_annotation/freezed_annotation.dart';
part 'example_freezed_state.dart';
part 'example_freezed_bloc.freezed.dart';
part 'example_freezed_event.dart';

@freezed
 class ExampleFreezedBloc with _$ExampleFreezedBloc {
   factory ExampleFreezedBloc() = _ExampleFreezedBloc;
}