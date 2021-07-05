class ExplorerItem {
  String name;
  String path;
  String? extension ;
  bool isDirectory;
  int size;
  int itemsLength ;

  ExplorerItem(
      {this.name = "",
      this.path = '',
      this.extension,
      this.size = 0,
      this.itemsLength=0,
      this.isDirectory = false});

  String get uniquePath {
    return "$path.$extension";
  }
}
