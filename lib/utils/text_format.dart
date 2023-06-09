class TextFormat {
  static String getInitials(String fullName) {
    List<String> names = fullName.split(" ");
    String initials = "";
    for (String name in names) {
      if (name.isNotEmpty) {
        initials += name[0].toUpperCase();
      }
    }
    return initials;
  }
}
