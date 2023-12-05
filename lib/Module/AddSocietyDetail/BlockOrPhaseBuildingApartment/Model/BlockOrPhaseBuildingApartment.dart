class BlockOrPhaseBuildingApartment {
  BlockOrPhaseBuildingApartment({
    required this.data,
  });
  late final List<Data> data;
  
  BlockOrPhaseBuildingApartment.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.societybuildingfloorid,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int societybuildingfloorid;
  late final String name;
  late final String createdAt;
  late final String updatedAt;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    societybuildingfloorid = json['societybuildingfloorid'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['societybuildingfloorid'] = societybuildingfloorid;
    _data['name'] = name;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}