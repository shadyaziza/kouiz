import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexStateProvider = StateProvider.autoDispose<PageController>(
    (ref) => PageController(initialPage: 0));
