import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:mimir/src/native/ffi.g.dart';
import 'package:mimir/src/native/proto/instance/request.pb.dart';

/// Adds safety by wrapping around
/// [embedded_milli_process_instance_request] and [embedded_milli_free_buffer].
InstanceFfiResponse _processInstanceRequest(InstanceFfiRequest request) {
  // NOTE: explicit type annotation so it's clear we are handling a byte buffer
  // ignore: omit_local_variable_types
  final Uint8List serializedRequestBytes = request.writeToBuffer();
  final bufferLength = serializedRequestBytes.length;
  final requestBufferPtr = malloc.allocate<Uint8>(bufferLength);
  try {
    requestBufferPtr
        .asTypedList(bufferLength)
        .setAll(0, serializedRequestBytes);

    final responseBuffer = embedded_milli_process_instance_request(
      requestBufferPtr,
      bufferLength,
    );
    try {
      final RustBuffer(:ptr, :len) = responseBuffer;
      return InstanceFfiResponse.fromBuffer(ptr.asTypedList(len));
    } finally {
      embedded_milli_free_buffer(responseBuffer);
    }
  } finally {
    malloc.free(requestBufferPtr);
  }
}

/// Sends the supplied [request] over FFI,
/// transforming the response with [transform].
///
/// These actions occur in a new [Isolate] to prevent blocking the caller,
/// as some FFI calls + [transform]s can take several milliseconds.
Future<T> processInstanceRequest<T>(
  InstanceFfiRequest request,
  FutureOr<T> Function(InstanceFfiResponse) transform,
) => Isolate.run(() => transform(_processInstanceRequest(request)));
