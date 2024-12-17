// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState {
  final int count;
  final bool isActive;
  HomeState({this.count = 0, this.isActive = false});

  HomeState copyWith({
    int? count,
    bool? isActive,
  }) {
    return HomeState(
      count: count ?? this.count,
      isActive: isActive ?? this.isActive,
    );
  }
}
