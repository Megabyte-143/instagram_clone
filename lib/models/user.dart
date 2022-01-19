class User {
  final String uid;
  final String email;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
