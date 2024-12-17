import 'package:joytime/resources/dimens/app_dimens.dart';

extension GetSizeScreen on num {
  double get w {
    return (Dimens.ratioWidth) * this;
  }

  double get h {
    return (Dimens.ratioHeight) * this;
  }

  double get sp {
    return this * Dimens.scaleFontsize;
  }
}
