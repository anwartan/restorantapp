class Item{
  late String name;
  
  Item({
    required this.name
  });
  factory Item.fromJson(Map<String, dynamic> item)=> Item(name: item['name']);
  Map<String,dynamic> toJson()=>{
    "name":name,
  };
}
