class AuthData {
  final String token;
  final String refreshToken;
  final int expiresIn;

  AuthData(
      {required this.token,
        required this.refreshToken,
        required this.expiresIn});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    print("token: $json");
    return AuthData(
      token: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': token,
    'refreshToken': refreshToken,
    'expiresIn': expiresIn
  };
}
