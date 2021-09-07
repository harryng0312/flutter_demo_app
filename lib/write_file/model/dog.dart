import 'package:json_annotation/json_annotation.dart';

// not need - can do by manual
// part 'dog.g.dart';

// @JsonSerializable(explicitToJson: true)
class Dog {
  late int id;
  late String name;
  late int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }

  factory Dog.fromJson(Map<String, dynamic> jsonMap) {
    return Dog(id: jsonMap["id"], name: jsonMap["name"], age: jsonMap["age"]);
  }
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
