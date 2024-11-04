  import 'package:itx_validator/src/validators/itx_validator_builder.dart';

extension CommonValidatorExtensions<T> on ItxValidator<T> {
  /// add a validation to check if the value is null or empty
  /// [message] is the message to return if the validation fails
  ItxValidator<T> required([String? message]) => addValidation(
        (v, [_]) => v == null || v.isNullOrEmpty
            ? message ?? 'This field is required'
            : null,
      );

}

extension OptionalValidation<T> on T? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is String) {
      return (this as String).isEmpty || (this as String).trim().isEmpty;
    }
    if (this is List) {
      return (this as List).isEmpty;
    }
    if (this is Map) {
      return (this as Map).isEmpty;
    }
    return false;
  }
}