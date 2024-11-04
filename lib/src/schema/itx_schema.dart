import 'package:itx_validator/src/abstracts/schema_value.dart';

import '../validators/itx_validator_builder.dart';

class ItxSchema  extends SchemaValue {
  /// create a schema with the given schema values.
  ///
  /// structure is a `Map<String, SchemaValue>`
  ItxSchema.structure(
    this._schema);

  final Map<String, SchemaValue> _schema;

  /// access schema values
  Map<String, SchemaValue> get schema => _schema;


  /// get the values of the schema with specific key
  SchemaValue operator [](String key) => _schema[key]!;

  /// validate the values you have sent and return a [Map]
  /// with errors. each error will have the key from form keys
  ///
  /// if there is no errors it will return an empty `Map`
  Map<dynamic, dynamic> catchErrors(Map<dynamic, dynamic> form) {


    Map<dynamic, dynamic> errors = {};
    _schema.forEach((key, value) {
      if (value is ItxValidator) {
        var error = value.build()(form[key], form);
        if (error != null) {
          errors[key] = error;
        }
      } else if (value is ItxSchema) {
        var nestedErrors = value.catchErrors(form[key] ?? {});
        if (nestedErrors.isNotEmpty) {
          errors[key] = nestedErrors;
        }
      }
    });


    return errors;
  }


  /// validate the values you have sent and return a [Map]
  ///
  /// It will return a `Map` with errors and the data
  (Map<dynamic, dynamic> data, Map<dynamic, dynamic> errors) validateSync(
    Map<dynamic, dynamic> form,
  ) {
    final errors = catchErrors(form);
    return (form, errors);
  }



}