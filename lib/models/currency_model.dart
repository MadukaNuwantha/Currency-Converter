class Currency {
  String? code;
  String? name;
  double? rate;

  Currency({
    this.code,
    this.name,
    this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'rate': rate,
    };
  }
}
