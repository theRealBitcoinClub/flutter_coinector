class RouterPath {
  final String search;
  final bool isUnknown;

  RouterPath.home()
      : search = "",
        isUnknown = false;

  RouterPath.filtered(this.search) : isUnknown = false;

  RouterPath.unknown()
      : search = "",
        isUnknown = true;

  bool get isHomePage => search.isEmpty;

  bool get isFilteredPage => search.isNotEmpty;
}
