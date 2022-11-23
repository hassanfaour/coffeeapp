import 'package:coffeeapp/model/models.dart';

abstract class BaseNetworkRepository{
  Future<NetWorkModel> networkAnswer();
}