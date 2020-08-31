part of 'mask_bloc.dart';

abstract class MaskState extends Equatable {
  const MaskState();
}

class MaskInitial extends MaskState {
  @override
  List<Object> get props => [];
}

class GetMaskState extends MaskState {
  final MaskList maskList;
  const GetMaskState(this.maskList);

  @override
  List<Object> get props => [maskList];
}

class LoadingMaskState extends MaskState {
  @override
  List<Object> get props => [];
}

class FailedFetchMaskState extends MaskState {
  @override
  List<Object> get props => [];
}