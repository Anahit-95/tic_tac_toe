import 'package:flutter/widgets.dart';

mixin StateAddition<T extends StatefulWidget> on State<T> {
  double get width_ => MediaQuery.of(context).size.width;
  double get height_ => MediaQuery.of(context).size.height;
}

mixin StateLessAddition on StatelessWidget {
  double width_(BuildContext context) => MediaQuery.of(context).size.width;
  double height_(BuildContext context) => MediaQuery.of(context).size.height;
}
