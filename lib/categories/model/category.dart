class Category {
  final String name;
  final String _imagePath;

  const Category({required this.name})
      : this._imagePath = 'assets/icons/$name.png';
  String get imagePath => _imagePath;
}
