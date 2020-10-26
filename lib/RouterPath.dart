class RouterPath {
  final String search;
  final bool isUnknown;

  RouterPath.home()
      : search = null,
        isUnknown = false;

  RouterPath.filtered(this.search) : isUnknown = false;

  RouterPath.unknown()
      : search = null,
        isUnknown = true;

  bool get isHomePage => search == null;

  bool get isFilteredPage => search != null;
}
