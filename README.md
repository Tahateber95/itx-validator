<p align="center">
  <a href="#"><img src="https://i.postimg.cc/dt69yJHT/g3.png" height=250 /></a>
</p>

# ItxValidator

ItxValidator a simple approach to field and object schema validation tailored for Flutter.

## Installing

Add ItxValidator to your pubspec:

```yaml
dependencies:
  itx_validator: any # or the latest version on Pub
```

## Getting Started

To begin with `ItxValidator`, define a schema object that represents the structure and validation rules for your data. Below is an example demonstrating how to create a schema for user data, including validations for email, password, and date fields.

### Defining a Schema

Create a schema using `ItxSchema.structure` where each field in the data object is associated with an `ItxValidator` specifying its validation rules:

```dart
final ItxSchema formSchema = ItxSchema.structure(
  {
     "email": ItxValidator<String>()
      .required(message: 'Email is required')
      .email(message: 'Email is invalid'),
    "password": ItxValidator<String>().required(),
    'date': ItxValidator<num>().required()
  },
);
