class LoveDayModel {
  late int? loveday;
  late String gender;
  late String imageMen;
  late String nameMen;
  late String nameWoman;
  late String imageWoman;
  late String dobMen;
  late String dobWoman;
  late bool isAddPhoto;
  late bool isLanguage;

  LoveDayModel(
      {this.gender = '',
      this.loveday,
      this.imageMen = '',
      this.imageWoman = '',
      this.nameMen = '',
      this.nameWoman = '',
      this.dobMen = '',
      this.dobWoman = '',
      this.isAddPhoto = false,
      this.isLanguage = false});

  LoveDayModel.formJson(Map<String, dynamic> json) {
    loveday = json['loveday'];
    gender = json['gender'];
    imageMen = json['imageMen'] ?? '';
    imageWoman = json['imageWoman'] ?? '';
    nameMen = json['nameMen'] ?? '';
    nameWoman = json['nameWoman'] ?? '';
    dobMen = json['dobMen'] ?? '';
    dobWoman = json['dobWoman'] ?? '';
    isAddPhoto = json['isAddPhoto'] ?? false;
    isLanguage = json['isLanguage'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'loveday': loveday,
      'gender': gender,
      'imageMen': imageMen,
      'imageWoman': imageWoman,
      'nameMen': nameMen,
      'nameWoman': nameWoman,
      'dobMen': dobMen,
      'dobWoman': dobWoman,
      'isAddPhoto': isAddPhoto,
      'isLanguage': isLanguage,
    };
  }

  LoveDayModel copyWith({
    int? loveday,
    String? gender,
    String? imageMen,
    String? imageWoman,
    String nameMen = '',
    String nameWoman = '',
    String dobMen = '',
    String dobWoman = '',
    bool? isAddPhoto,
    bool? isLanguage,
  }) {
    return LoveDayModel(
      loveday: loveday ?? this.loveday,
      gender: gender ?? this.gender,
      imageMen: imageMen ?? this.imageMen,
      imageWoman: imageWoman ?? this.imageWoman,
      nameMen: nameMen,
      nameWoman: nameWoman,
      dobMen: dobMen,
      dobWoman: dobWoman,
      isAddPhoto: isAddPhoto ?? this.isAddPhoto,
      isLanguage: isLanguage ?? this.isLanguage,
    );
  }
}
