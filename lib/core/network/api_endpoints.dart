class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  // GET and POST requests
  static const String objects = '/objects';

  // GET, PUT, PATCH and DELETE requests
  static String objectDetails(String id) => '/objects/$id';
}
