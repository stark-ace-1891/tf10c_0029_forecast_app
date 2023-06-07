class NothingGeocodeException implements Exception {
  final String message;
  NothingGeocodeException(
      {this.message = 'Error al momento de hacer la consulta'});
}

class InvalidApiKeyException implements Exception {}

class ServerErrorException implements Exception {}
