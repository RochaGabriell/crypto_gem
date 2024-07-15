import 'package:crypto_gem/domain/services/base_service.dart';
// Constants
import 'package:crypto_gem/constants/api_constants.dart';
// Models
import 'package:crypto_gem/domain/models/coins.dart';

class CoinsService extends BaseService {
  final String campaignUrl = ApiConstants.coinUrl;

  CoinsService(super.dio);

  Future<List<CoinModel>> getCoins({
    String vsCurrency = 'brl',
    int? page,
    String? ids,
  }) async {
    final Map<String, dynamic> params = {};
    if (page != null) params['page'] = page;
    if (ids != null) params['ids'] = ids;

    params['per_page'] = 20;
    params['vs_currency'] = vsCurrency;
    params['x_cg_demo_api_key'] = ApiConstants.apiKey;

    final response = await performHttpOperation(
      'GET',
      campaignUrl,
      queryParameters: params,
    );
    if (response.statusCode == 200) {
      final List<CoinModel> coins = [];
      final bodyDecoded = response.data;
      bodyDecoded.map((coin) => coins.add(CoinModel.fromJson(coin))).toList();
      return coins;
    } else {
      throw ('Erro ao carregar moedas');
    }
  }
}
