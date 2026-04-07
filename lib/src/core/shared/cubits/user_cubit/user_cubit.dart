import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/widgets/un_autheticated/unauthenticated_bottomsheet.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/network/network_request.dart';
import 'package:mazaya/src/core/helpers/cache_service.dart';
import 'package:mazaya/src/core/network/network_service.dart';
import 'package:mazaya/src/core/shared/models/user_model.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/features/home/presentation/cubits/home_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/favourite/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/used_coupons/presentation/imports/view_imports.dart';
part 'user_state.dart';
part 'user_utils.dart';

const String _userKey = 'user';
const String _tokenKey = 'token';
const String _selectedCountryKey = 'selected_country';
const String _selectedCityKey = 'selected_city';
const String _selectedRegionKey = 'selected_region';

@lazySingleton
class UserCubit extends Cubit<UserState> with UserUtils {
  UserCubit() : super(UserState.initial());

  Future<void> setUserLoggedIn({
    required UserModel user,
    required String token,
  }) async {
    await Future.wait([_saveUser(user), _saveToken(token)]);
    injector<NetworkService>().setToken(token);

    // Restore hierarchy from cache after logout cleared the state
    final countryMap = CacheStorage.read(_selectedCountryKey, isDecoded: true);
    final cityMap = CacheStorage.read(_selectedCityKey, isDecoded: true);
    final regionMap = CacheStorage.read(_selectedRegionKey, isDecoded: true);

    if (isClosed) return;
    emit(
      state.copyWith(
        userModel: user,
        userStatus: UserStatus.loggedIn,
        selectedCountry:
            countryMap != null ? CountryEntity.fromJson(countryMap) : null,
        selectedCity: cityMap != null ? CityEntity.fromJson(cityMap) : null,
        selectedRegion:
            regionMap != null ? RegionEntity.fromJson(regionMap) : null,
      ),
    );
  }

  Future<void> updateLocationHierarchy({
    CountryEntity? country,
    CityEntity? city,
    RegionEntity? region,
  }) async {
    await Future.wait([
      if (country != null)
        CacheStorage.write(_selectedCountryKey, country.toJson()),
      if (city != null) CacheStorage.write(_selectedCityKey, city.toJson()),
      if (region != null) CacheStorage.write(_selectedRegionKey, region.toJson()),
    ]);

    if (isClosed) return;
    emit(
      state.copyWith(
        selectedCountry: country,
        selectedCity: city,
        selectedRegion: region,
      ),
    );
  }

  Future<void> logout({bool clearOnboarding = false}) async {
    await Future.wait([
      CacheStorage.delete(_userKey),
      SecureStorage.delete(_tokenKey),
      if (clearOnboarding) CacheStorage.delete(ConstantManager.sawOnboarding),
    ]);
    _clearAllData();
    clearUser();
    if (isClosed) return;
    emit(state.copyWith(userStatus: UserStatus.loggedOut));
  }

  void _clearAllData() {
    injector<HomeCubit>().clear();
    injector<CouponsCubit>().reset();
    injector<FavouriteCubit>().reset();
    injector<UsedCouponsCubit>().clear();
  }

  Future<void> updateToken(String token) async {
    _saveToken(token);
  }

  Future<void> updateUser(UserModel user) async {
    await _saveUser(user);
    if (isClosed) return;
    emit(state.copyWith(userModel: user));
  }

  Future<void> getProfile() async {
    final request = NetworkRequest(
      method: RequestMethod.get,
      path: ApiConstants.profile,
    );
    final response = await injector<NetworkService>().callApi<UserModel>(
      request,
      mapper: (json) => UserModel.fromJson(json),
    );
    if (response.key.toLowerCase() == 'success') {
      await updateUser(response.data);
    }
  }

  Future<bool> init() async {
    final Map<String, dynamic>? userMap = CacheStorage.read(
      _userKey,
      isDecoded: true,
    );
    final token = await SecureStorage.read(_tokenKey);

    // Restore location hierarchy
    final countryMap = CacheStorage.read(_selectedCountryKey, isDecoded: true);
    final cityMap = CacheStorage.read(_selectedCityKey, isDecoded: true);
    final regionMap = CacheStorage.read(_selectedRegionKey, isDecoded: true);

    log('userMap $userMap, token $token');
    if (token != null && userMap != null) {
      injector<NetworkService>().setToken(token);
      if (isClosed) return false;
      emit(
        state.copyWith(
          userModel: UserModel.fromJson(userMap),
          userStatus: UserStatus.loggedIn,
          selectedCountry:
              countryMap != null ? CountryEntity.fromJson(countryMap) : null,
          selectedCity: cityMap != null ? CityEntity.fromJson(cityMap) : null,
          selectedRegion:
              regionMap != null ? RegionEntity.fromJson(regionMap) : null,
        ),
      );
      return true;
    }
    return false;
  }

  void clearUser() {
    injector<NetworkService>().removeToken();
    emit(UserState.initial());
  }

  UserModel get user => state.userModel;
  static UserCubit get instance => injector<UserCubit>();

  bool get isUserLoggedIn => state.userStatus == UserStatus.loggedIn;

  bool checkAuth({bool isGuest = true}) {
    if (!isUserLoggedIn) {
      UnAuthenticatedBottomSheet.show(isBlocked: false, isGuest: isGuest);
      return false;
    }
    return true;
  }
}
