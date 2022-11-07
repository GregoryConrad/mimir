export 'package:embedded_meilisearch/embedded_meilisearch.dart';
export 'src/flutter_interface.dart';
export 'src/flutter_interface_ffi.dart'
    if (dart.library.io) 'src/flutter_interface_ffi.io.dart'
    if (dart.library.html) 'src/flutter_interface_ffi.web.dart';
