class Responsive {
  Responsive(double width, double height) {
    this._shortDimension = width < height ? width : height;
    this._longDimension = width < height ? height : width;
  }

  var _shortDimension;
  var _longDimension;

  double hp(size) {
    return (this._longDimension * size) / 100;
  }

  double wp(size) {
    return (this._shortDimension * size) / 100;
  }
}
