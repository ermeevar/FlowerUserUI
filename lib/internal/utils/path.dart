class Path {
  static String getFilename(String path) {
    return path.split("/").last.split(".").first;
  }
}
