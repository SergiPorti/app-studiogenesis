class Failure implements Exception {
  late final String message;
  late final String extensionMessage;
  Failure(
      {this.message = 'Undefined error',
      this.extensionMessage = "Server error"});

  @override
  String toString() => message;
}
