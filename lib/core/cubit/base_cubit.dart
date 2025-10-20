import 'package:flutter/material.dart';

mixin BaseCubit {
  BuildContext? context;
  void init();
  void setContext(BuildContext context);
}
