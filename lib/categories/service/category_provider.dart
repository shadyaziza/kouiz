import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category.dart';

final categoryProvider = Provider<Set<Category>>(
  (ref) {
    return const {
      Category(name: 'javascript'),
      Category(name: 'linux'),
      Category(name: 'python'),
      Category(name: 'ansible'),
      Category(name: 'bash'),
      Category(name: 'docker'),
      Category(name: 'html'),
      Category(name: 'kubernetes'),
      Category(name: 'laravel'),
    };
  },
);
