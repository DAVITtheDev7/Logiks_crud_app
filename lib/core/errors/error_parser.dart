class ErrorParser {
  static String parse(String rawMessage, {String? contextId}) {
    // Handle the specific read-only seed object error
    if (rawMessage.contains('405') || _isSeedId(contextId)) {
      return 'Seed objects are read-only. Try editing a created object.';
    }

    if (rawMessage.toLowerCase().contains('network is unreachable')) {
      return 'Please check your internet connection.';
    }

    return rawMessage;
  }

  // Helper to check if the ID belongs to the default 1-13 seed objects
  static bool _isSeedId(String? id) {
    if (id == null) return false;
    final parsedId = int.tryParse(id);
    return parsedId != null && parsedId <= 13;
  }
}
