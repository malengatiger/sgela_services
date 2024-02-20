
import '../data/sgela_user.dart';
import '../services/local_data_service.dart';
import '../sgela_util/dio_util.dart';

class SgelaUserRepository {
  final DioUtil dioUtil;
  final LocalDataService localDataService;

  static const mm = '💦💦💦💦 SgelaUserRepository 💦';


  SgelaUserRepository(this.dioUtil, this.localDataService);

  Future<SgelaUser?> registerSgelaUser(SgelaUser user) async {
    return null;
  }

  Future<List<SgelaUser>> getSgelaUsers(String organizationId) async {

      return [];

  }


}
