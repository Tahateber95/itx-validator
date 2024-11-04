/// SchemaValue - Abstract Class for Schema Elements
///
/// This abstract class serves as the base for schema elements in the `ITXSchema` system.
/// It is designed to enforce type safety within the `ITXSchema` class, ensuring that the schema
/// can only contain elements that are either instances of `ITXValidator` or `ITXSchema`.
abstract class SchemaValue {}
