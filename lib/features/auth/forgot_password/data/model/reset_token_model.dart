class ResetTokenModel {
  final String resetToken;

  const ResetTokenModel({required this.resetToken});

  factory ResetTokenModel.fromJson(Map<String, dynamic> json) {
    return ResetTokenModel(resetToken: json['resetToken'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'resetToken': resetToken};
  }
}
