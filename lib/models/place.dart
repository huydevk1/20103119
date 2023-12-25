class Place{
  int id;
  String name;
  Place(this.id, this.name);
}

class City extends Place{
  City({required id, required name}):super(id, name);
  factory City.fromJson(Map<String, dynamic> json)
  {
    return City(
      id: json['ProvinceID'], 
      name: json['ProviceName']
    );
  }
}

class District extends Place {
  int leve;
  District({required id, required name, required this.leve}):super(id, name);
  factory District.fromJson(Map<String, dynamic> json)
  {
    return District(
      id: json['DistrictID'], 
      name: json['DistrictName'], 
      leve: json['type']
    );
  }
}


class Ward extends Place{
  Ward({required id, required name}):super(id, name);
  factory Ward.fromJson(Map<String, dynamic> json)
  {
    return Ward(
      id: int.parse(json['WardCode']), 
      name: json['WardName']
    );
  }
}