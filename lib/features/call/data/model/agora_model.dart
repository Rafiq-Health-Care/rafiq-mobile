class AgoraModel {
  final String channelName;
  final String token;

  AgoraModel({required this.channelName, required this.token});

  factory AgoraModel.fromJson(Map<String, dynamic> json) {
    return AgoraModel(channelName: json['channelName'], token: json['token']);
  }
}
