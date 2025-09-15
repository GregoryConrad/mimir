/// An [Exception] thrown by mimir.
final class MimirException implements Exception {
  /// Constructs a [MimirException] with the supplied [message].
  const MimirException(this.message);

  /// A description of what went wrong.
  final String message;

  @override
  String toString() => 'MimirException(message: $message)';
}
