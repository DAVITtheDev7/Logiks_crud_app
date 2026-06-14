class ErrorParser {
  static String parse(String rawMessage, {String? contextId}) {
    final normalized = rawMessage.toLowerCase();

    if (normalized.contains('network is unreachable') ||
        normalized.contains('socketexception') ||
        normalized.contains('connection error')) {
      return 'Please check your internet connection.';
    }

    if (_isReadOnlySeedObjectError(normalized, contextId)) {
      return 'Seed objects are read-only.';
    }

    return rawMessage;
  }

  static bool _isReadOnlySeedObjectError(String message, String? contextId) {
    final is405 =
        message.contains('405') || message.contains('method not allowed');

    final mentionsReservedObject =
        message.contains('reserved id') ||
        message.contains('cannot be overridden') ||
        message.contains('read-only');

    return is405 && (_isSeedId(contextId) || mentionsReservedObject);
  }

  static bool _isSeedId(String? id) {
    if (id == null) return false;

    final parsedId = int.tryParse(id);
    return parsedId != null && parsedId >= 1 && parsedId <= 13;
  }
}
