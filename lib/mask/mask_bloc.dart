import 'dart:async';
import 'package:flutter_app/mask/model/mask_list.dart';
import 'mask_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mask_event.dart';
part 'mask_state.dart';

class MaskBloc extends Bloc<MaskEvent, MaskState> {
  MaskBloc() : super(MaskInitial());
  MaskProvider maskProvider = new MaskProvider();
  @override
  Stream<MaskState> mapEventToState(
    MaskEvent event,
  ) async* {
    if (event is FetchMaskDataEvent)
      yield* _mapFetchMaskDataToState(city: event.city);
  }

  Stream<MaskState> _mapFetchMaskDataToState({String city}) async* {
    yield LoadingMaskState();
    try {
      final _maskList = await maskProvider.fetchMaskData(city);
      yield GetMaskState(_maskList);
    } catch (_) {
      yield FailedFetchMaskState();
    }
  }
}
