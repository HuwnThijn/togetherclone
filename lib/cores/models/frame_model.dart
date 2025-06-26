class FrameModel {
  late String path;
  late bool isBuy;

  FrameModel({
    required this.isBuy,
    required this.path,
  });

  FrameModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    isBuy = json['isBuy'];
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'isBuy': isBuy,
    };
  }
}
