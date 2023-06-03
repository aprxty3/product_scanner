class ProductModel {
  String? code;
  String? name;
  int? qty;
  String? id;

  ProductModel({
    this.code,
    this.name,
    this.qty,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? '',
        name: json["name"] ?? '',
        qty: json["qty"] ?? 0,
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "qty": qty,
        "id": id,
      };
}
