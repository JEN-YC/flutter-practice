part of 'mask_bloc.dart';

abstract class MaskEvent extends Equatable {
  const MaskEvent();
}

class FetchMaskDataEvent extends MaskEvent {
  final String city;

  const FetchMaskDataEvent(this.city);
  @override
  List<Object> get props => [city];
}
