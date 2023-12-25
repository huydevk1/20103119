import 'package:connection/models/lop.dart';
import 'package:connection/services/api_service.dart';


class LopRepository {
  Future<List<Lop>> getDsLop() async{
    List<Lop> list = [];
    list.add(Lop(ten: "--Chọn--"));
    final response = await ApiService().getDsLop();
    if (response != null) 
    {
      var data = response.data['data'];
      for (var item in data) {
        var lop = Lop.fromJson(item);
        list.add(lop);
      }
    }
    return list;
  }
}