import 'package:shakosh/main.dart';

double? mySize(double? xs, double? sm, double? md, double? lg, double? xl) {
  double width = screenWidth;
  double? newWidth = width;
  if (width >= 0) newWidth = xs;
  if (width >= 576) newWidth = sm;
  if (width >= 768) newWidth = md;
  if (width >= 992) newWidth = lg;
  if (width >= 1200) newWidth = xl;
  return newWidth;
}
