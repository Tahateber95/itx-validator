  import 'package:intl/intl.dart';
import 'package:itx_validator/src/validators/itx_validator_builder.dart';

extension CommonValidatorExtensions<T> on ItxValidator<T> {
  /// Adds a validation to check if the value is null or empty.
  /// [message] is the message to return if the validation fails.
  ItxValidator<T> required({required String message}) => addValidation(
        (v, [_]) => v == null || v.toString().isEmpty ? message : null,
      );

  /// Adds a validation to check if the value is a valid email.
  ItxValidator<T> email({required String message}) => addValidation(
        (v, [_]) => v == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.toString())
            ? message
            : null,
      );

  /// Adds a validation to check if the value is at least [minLength] characters long.
  ItxValidator<T> minLength(int minLength, {required String message}) => addValidation(
        (v, [_]) => v != null && v.toString().length < minLength ? message : null,
      );

  /// Adds a validation to check if the value does not exceed [maxLength] characters.
  ItxValidator<T> maxLength(int maxLength, {required String message}) => addValidation(
        (v, [_]) => v != null && v.toString().length > maxLength ? message : null,
      );

  /// Adds a validation to check if the value is numeric.
  ItxValidator<T> numeric({required String message}) => addValidation(
        (v, [_]) => v != null && double.tryParse(v.toString()) == null ? message : null,
      );

  /// Adds a validation to check if the value matches a specific [pattern].
  ItxValidator<T> pattern(String pattern, {required String message}) => addValidation(
        (v, [_]) => v != null && !RegExp(pattern).hasMatch(v.toString()) ? message : null,
      );

  /// Adds a validation to check if the value is within the range [min] to [max].
  ItxValidator<T> range(num min, num max, {required String message}) => addValidation(
        (v, [_]) {
          if (v == null) return null;
          final numValue = num.tryParse(v.toString());
          return numValue == null || numValue < min || numValue > max ? message : null;
        },
      );

        /// Adds a validation to check if the value matches a specific date [format].
  /// [message] is the message to return if the validation fails.
  ItxValidator<T> dateFormat(String format, {required String message}) => addValidation(
        (v, [_]) {
          if (v == null) return message;
          try {
            final dateFormat = DateFormat(format);
            dateFormat.parseStrict(v.toString());
            return null; // No error if parsing is successful
          } catch (e) {
            return message; // Error if parsing fails
          }
        },
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