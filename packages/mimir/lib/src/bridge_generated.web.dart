// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.53.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member

import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'bridge_generated.dart';
export 'bridge_generated.dart';
import 'package:meta/meta.dart';

class EmbeddedMilliPlatform extends FlutterRustBridgeBase<EmbeddedMilliWire>
    with FlutterRustBridgeSetupMixin {
  EmbeddedMilliPlatform(FutureOr<WasmModule> dylib)
      : super(EmbeddedMilliWire(dylib)) {
    setupMixinConstructor();
  }
  Future<void> setup() => inner.init;

// Section: api2wire

  @protected
  String api2wire_String(String raw) {
    return raw;
  }

  @protected
  List<String> api2wire_StringList(List<String> raw) {
    return raw;
  }

  @protected
  List<dynamic> api2wire_box_autoadd_filter(Filter raw) {
    return api2wire_filter(raw);
  }

  @protected
  List<dynamic> api2wire_box_autoadd_mimir_index_settings(
      MimirIndexSettings raw) {
    return api2wire_mimir_index_settings(raw);
  }

  @protected
  int /* *u32 */ api2wire_box_autoadd_u32(int raw) {
    return inner.new_box_autoadd_u32_0(api2wire_u32(raw));
  }

  @protected
  List<dynamic> api2wire_box_filter(Filter raw) {
    return api2wire_filter(raw);
  }

  @protected
  List<dynamic> api2wire_filter(Filter raw) {
    if (raw is Filter_Or) {
      return [0, api2wire_list_filter(raw.field0)];
    }
    if (raw is Filter_And) {
      return [1, api2wire_list_filter(raw.field0)];
    }
    if (raw is Filter_Not) {
      return [2, api2wire_box_filter(raw.field0)];
    }
    if (raw is Filter_Exists) {
      return [3, api2wire_String(raw.field)];
    }
    if (raw is Filter_InValues) {
      return [4, api2wire_String(raw.field), api2wire_StringList(raw.values)];
    }
    if (raw is Filter_GreaterThan) {
      return [5, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_GreaterThanOrEqual) {
      return [6, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_Equal) {
      return [7, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_NotEqual) {
      return [8, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_LessThan) {
      return [9, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_LessThanOrEqual) {
      return [10, api2wire_String(raw.field), api2wire_String(raw.value)];
    }
    if (raw is Filter_Between) {
      return [
        11,
        api2wire_String(raw.field),
        api2wire_String(raw.from),
        api2wire_String(raw.to)
      ];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> api2wire_list_filter(List<Filter> raw) {
    return raw.map(api2wire_filter).toList();
  }

  @protected
  List<dynamic> api2wire_list_sort_by(List<SortBy> raw) {
    return raw.map(api2wire_sort_by).toList();
  }

  @protected
  List<dynamic> api2wire_list_synonyms(List<Synonyms> raw) {
    return raw.map(api2wire_synonyms).toList();
  }

  @protected
  List<dynamic> api2wire_mimir_index_settings(MimirIndexSettings raw) {
    return [
      api2wire_opt_StringList(raw.searchableFields),
      api2wire_StringList(raw.filterableFields),
      api2wire_StringList(raw.sortableFields),
      api2wire_StringList(raw.rankingRules),
      api2wire_StringList(raw.stopWords),
      api2wire_list_synonyms(raw.synonyms),
      api2wire_bool(raw.typosEnabled),
      api2wire_u8(raw.minWordSizeForOneTypo),
      api2wire_u8(raw.minWordSizeForTwoTypos),
      api2wire_StringList(raw.disallowTyposOnWords),
      api2wire_StringList(raw.disallowTyposOnFields)
    ];
  }

  @protected
  String? api2wire_opt_String(String? raw) {
    return raw == null ? null : api2wire_String(raw);
  }

  @protected
  List<String>? api2wire_opt_StringList(List<String>? raw) {
    return raw == null ? null : api2wire_StringList(raw);
  }

  @protected
  int /* *u32 */ ? api2wire_opt_box_autoadd_u32(int? raw) {
    return raw == null ? 0 : api2wire_box_autoadd_u32(raw);
  }

  @protected
  List<dynamic>? api2wire_opt_list_sort_by(List<SortBy>? raw) {
    return raw == null ? null : api2wire_list_sort_by(raw);
  }

  @protected
  List<dynamic> api2wire_sort_by(SortBy raw) {
    if (raw is SortBy_Asc) {
      return [0, api2wire_String(raw.field0)];
    }
    if (raw is SortBy_Desc) {
      return [1, api2wire_String(raw.field0)];
    }

    throw Exception('unreachable');
  }

  @protected
  List<dynamic> api2wire_synonyms(Synonyms raw) {
    return [api2wire_String(raw.word), api2wire_StringList(raw.synonyms)];
  }

  @protected
  Uint8List api2wire_uint_8_list(Uint8List raw) {
    return raw;
  }
// Section: finalizer

}

// Section: WASM wire module

@JS('wasm_bindgen')
external EmbeddedMilliWasmModule get wasmModule;

@JS()
@anonymous
class EmbeddedMilliWasmModule implements WasmModule {
  external Object /* Promise */ call([String? moduleName]);
  external EmbeddedMilliWasmModule bind(dynamic thisArg, String moduleName);
  external void wire_enforce_binding(NativePortType port_);

  external void wire_ensure_instance_initialized(
      NativePortType port_, String instace_dir);

  external void wire_ensure_index_initialized(
      NativePortType port_, String instance_dir, String index_name);

  external void wire_add_documents(NativePortType port_, String instance_dir,
      String index_name, List<String> documents);

  external void wire_delete_documents(NativePortType port_, String instance_dir,
      String index_name, List<String> document_ids);

  external void wire_delete_all_documents(
      NativePortType port_, String instance_dir, String index_name);

  external void wire_set_documents(NativePortType port_, String instance_dir,
      String index_name, List<String> documents);

  external void wire_get_document(NativePortType port_, String instance_dir,
      String index_name, String document_id);

  external void wire_get_all_documents(
      NativePortType port_, String instance_dir, String index_name);

  external void wire_search_documents(
      NativePortType port_,
      String instance_dir,
      String index_name,
      String? query,
      int /* *u32 */ ? limit,
      List<dynamic>? sort_criteria,
      List<dynamic> filter,
      int matching_strategy);

  external void wire_get_settings(
      NativePortType port_, String instance_dir, String index_name);

  external void wire_set_settings(NativePortType port_, String instance_dir,
      String index_name, List<dynamic> settings);

  external int /* *mut u32 */ new_box_autoadd_u32_0(int value);
}

// Section: WASM wire connector

class EmbeddedMilliWire
    extends FlutterRustBridgeWasmWireBase<EmbeddedMilliWasmModule> {
  EmbeddedMilliWire(FutureOr<WasmModule> module)
      : super(WasmModule.cast<EmbeddedMilliWasmModule>(module));

  void wire_enforce_binding(NativePortType port_) =>
      wasmModule.wire_enforce_binding(port_);

  void wire_ensure_instance_initialized(
          NativePortType port_, String instace_dir) =>
      wasmModule.wire_ensure_instance_initialized(port_, instace_dir);

  void wire_ensure_index_initialized(
          NativePortType port_, String instance_dir, String index_name) =>
      wasmModule.wire_ensure_index_initialized(port_, instance_dir, index_name);

  void wire_add_documents(NativePortType port_, String instance_dir,
          String index_name, List<String> documents) =>
      wasmModule.wire_add_documents(port_, instance_dir, index_name, documents);

  void wire_delete_documents(NativePortType port_, String instance_dir,
          String index_name, List<String> document_ids) =>
      wasmModule.wire_delete_documents(
          port_, instance_dir, index_name, document_ids);

  void wire_delete_all_documents(
          NativePortType port_, String instance_dir, String index_name) =>
      wasmModule.wire_delete_all_documents(port_, instance_dir, index_name);

  void wire_set_documents(NativePortType port_, String instance_dir,
          String index_name, List<String> documents) =>
      wasmModule.wire_set_documents(port_, instance_dir, index_name, documents);

  void wire_get_document(NativePortType port_, String instance_dir,
          String index_name, String document_id) =>
      wasmModule.wire_get_document(
          port_, instance_dir, index_name, document_id);

  void wire_get_all_documents(
          NativePortType port_, String instance_dir, String index_name) =>
      wasmModule.wire_get_all_documents(port_, instance_dir, index_name);

  void wire_search_documents(
          NativePortType port_,
          String instance_dir,
          String index_name,
          String? query,
          int /* *u32 */ ? limit,
          List<dynamic>? sort_criteria,
          List<dynamic> filter,
          int matching_strategy) =>
      wasmModule.wire_search_documents(port_, instance_dir, index_name, query,
          limit, sort_criteria, filter, matching_strategy);

  void wire_get_settings(
          NativePortType port_, String instance_dir, String index_name) =>
      wasmModule.wire_get_settings(port_, instance_dir, index_name);

  void wire_set_settings(NativePortType port_, String instance_dir,
          String index_name, List<dynamic> settings) =>
      wasmModule.wire_set_settings(port_, instance_dir, index_name, settings);

  int /* *mut u32 */ new_box_autoadd_u32_0(int value) =>
      wasmModule.new_box_autoadd_u32_0(value);
}
