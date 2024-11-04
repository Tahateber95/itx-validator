

import '../abstracts/schema_value.dart';

typedef ValidationCallback<T> = dynamic Function(
  T? value, [
  Map<dynamic, dynamic>? ref,
]);

class ItxValidator<T> extends SchemaValue {
  ItxValidator({
    this.defaultValue,
    this.label,
  });



  /// default is used when casting produces a `null` output value
  final T? defaultValue;

  /// Overrides the key name which is used in error messages.
  final String? label;


  final List<ValidationCallback<T>> validations = [];

  ItxValidator<T> addValidation(ValidationCallback<T> validator) {
    validations.add(validator);
    return this;
  }


  /// Global validators
  dynamic validate(T? value, [Map<dynamic, dynamic>? entireData]) =>
      _test(value, entireData);

  dynamic _test(T? value, [Map<dynamic, dynamic>? ref]) {
    try {
      if (value == null && defaultValue != null) {
        value = defaultValue;
      }

      for (var validate in validations) {
        final result = validate(value, ref);
        if (result != null) {
          return result;
        }
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  ValidationCallback<T> build() => _test;
}
