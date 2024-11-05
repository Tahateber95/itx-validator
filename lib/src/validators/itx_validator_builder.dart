

import '../abstracts/schema_value.dart';

typedef ValidationCallback<T> = dynamic Function(
  T? value, [
  Map<dynamic, dynamic>? ref,
]);

class ItxValidator<T> extends SchemaValue {
  ItxValidator();

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
