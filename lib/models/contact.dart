const String tableName = "contacts";

const String idField = "_id";
const String firstNameField = "first_name";
const String lastNameField = "last_name";
const String phoneNumberField = "phone_number";
const String emailField = "email";

const List<String> contactColumns = [
  idField,
  firstNameField,
  lastNameField,
  phoneNumberField,
  emailField,
];

const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const String textTypeNullable = "TEXT";
const String textType = "TEXT NOT NULL";

class Contact {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;

  const Contact({
    this.id,
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.email,
  });

  static Contact fromJson(Map<String, dynamic> json) => Contact(
        id: json[idField] as int?,
        firstName: json[firstNameField] as String?,
        lastName: json[lastNameField] as String?,
        phoneNumber: json[phoneNumberField] as String?,
        email: json[emailField] as String?,
      );

  Map<String, dynamic> toJson() => {
        idField: id,
        firstNameField: firstName,
        lastNameField: lastName,
        phoneNumberField: phoneNumber,
        emailField: email,
      };

  Contact copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) =>
      Contact(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
      );
}
