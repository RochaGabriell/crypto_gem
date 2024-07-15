import 'package:flutter/material.dart';

// Model
import 'package:crypto_gem/domain/models/coins.dart';
// Repository
import 'package:crypto_gem/domain/repositories/coins.dart';

class CoinsStore extends ChangeNotifier {
  final ICoinsRepository _coinsRepository;

  CoinsStore(this._coinsRepository);

  bool? _loading;
  bool? get loading => _loading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<CoinModel>? _coins;
  List<CoinModel>? get coins => _coins;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  CoinModel? _coinSelected;
  CoinModel? get coinSelected => _coinSelected;

  final List<CoinModel> _favoritesList = [];
  List<CoinModel> get favoritesList => _favoritesList;

  Future<void> _fetchCoins(Future<List<CoinModel>> Function() fetch) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _coins = await fetch();
    } catch (e) {
      if (e is Map) {
        _errorMessage = e['message'];
      } else {
        _errorMessage = e.toString();
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getCoinsByIds({String? ids}) async {
    await _fetchCoins(() => _coinsRepository.getCoins(ids: ids));
  }

  Future<void> getCoins({int? page}) async {
    await _fetchCoins(() => _coinsRepository.getCoins(page: page));
  }

  void setFavoritesList(CoinModel favorites) {
    _favoritesList.add(favorites);
    notifyListeners();
  }

  void removeFavoritesList(CoinModel favorites) {
    _favoritesList.remove(favorites);
    notifyListeners();
  }

  void setCoinSelected(CoinModel? coin) {
    _coinSelected = coin;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void clearAll() {
    _coins = null;
    _currentPage = 1;
    notifyListeners();
  }
}
