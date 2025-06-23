class MaleModel {
  late final String name;
  late final String avatar;
  late final int birthday;
  MaleModel({required this.avatar, required this.birthday, required this.name});

  MaleModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'birthday': birthday,
    };
  }
}
