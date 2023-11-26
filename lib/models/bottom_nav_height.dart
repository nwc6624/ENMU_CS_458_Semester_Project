class BottomNavHeightWithSafeArea {
  double? bottomSafeAreaPadding;

  BottomNavHeightWithSafeArea({this.bottomSafeAreaPadding = 0});

  double? get getBottomSafeAreaPadding {
    return bottomSafeAreaPadding;
  }

  void setBottomSafeAreaPadding(double bottomPadding) {
    bottomSafeAreaPadding = bottomPadding;
  }
}
