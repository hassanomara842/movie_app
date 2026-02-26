class HomeLayoutStates {}

class HomeLayoutInitState extends HomeLayoutStates {}

class HomeLayoutChangeIndexState extends HomeLayoutStates {
  final int index;
  HomeLayoutChangeIndexState({required this.index});
}
