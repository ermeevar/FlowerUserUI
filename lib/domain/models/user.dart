import 'package:flower_user_ui/domain/models/user_metadata.dart';

class User {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final bool isAnonymous;
  final UserMetadata metadata;

  User(
      {required this.id,
      this.email,
      this.phoneNumber,
      this.displayName,
      this.photoUrl,
      required this.emailVerified,
      required this.isAnonymous,
      required this.metadata});
}
