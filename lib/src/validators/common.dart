  import 'package:itx_validator/src/validators/itx_validator_builder.dart';

extension CommonValidatorExtensions<T> on ItxValidator<T> {
  /// add a validation to check if the value is null or empty
  /// [message] is the message to return if the validation fails
ItxValidator<T> required({required String message}) => addValidation(
        (v, [_]) => v == null || v.isNullOrEmpty
            ? message
            : null,
      );

  /// add a validation to check if the value is Email
ItxValidator<T> email({required String message}) => addValidation(
        (v, [_]) => v == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.toString())
            ? message
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