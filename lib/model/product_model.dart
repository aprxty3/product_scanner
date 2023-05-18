class ProductModel {
  int? code;
  String? name;
  int? qty;
  String? uid;

  ProductModel({
    this.code,
    this.name,
    this.qty,
    this.uid,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"],
        name: json["name"],
        qty: json["qty"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "qty": qty,
        "uid": uid,
      };
}
