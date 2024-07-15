// Model
import 'package:crypto_gem/domain/models/coins.dart';
// Service
import 'package:crypto_gem/domain/services/coins.dart';

abstract class ICoinsRepository {
  Future<List<CoinModel>> getCoins({
    String vsCurrency = 'brl',
    int? page,
    String? ids,
  });
}

class CoinsRepository implements ICoinsRepository {
  final CoinsService _coinsService;

  CoinsRepository(this._coinsService);

  @override
  Future<List<CoinModel>> getCoins({
    String vsCurrency = 'brl',
    int? page,
    int? perPage,
    String? ids,
  }) async {
    final response = await _coinsService.getCoins(
      vsCurrency: vsCurrency,
      page: page,
      ids: ids,
    );
    return response;
  }
}
