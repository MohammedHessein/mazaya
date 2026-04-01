part of 'user_cubit.dart';

enum UserStatus { loggedIn, loggedOut }

class UserState extends Equatable {
  final UserModel userModel;
  final UserStatus userStatus;
  final CountryEntity? selectedCountry;
  final CityEntity? selectedCity;
  final RegionEntity? selectedRegion;

  const UserState({
    required this.userModel,
    this.userStatus = UserStatus.loggedOut,
    this.selectedCountry,
    this.selectedCity,
    this.selectedRegion,
  });

  factory UserState.initial() {
    return UserState(
      userModel: UserModel.initial(),
      userStatus: UserStatus.loggedOut,
    );
  }

  UserState copyWith({
    UserModel? userModel,
    UserStatus? userStatus,
    CountryEntity? selectedCountry,
    CityEntity? selectedCity,
    RegionEntity? selectedRegion,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      userStatus: userStatus ?? this.userStatus,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedRegion: selectedRegion ?? this.selectedRegion,
    );
  }

  @override
  List<Object?> get props => [
        userModel,
        userStatus,
        selectedCountry,
        selectedCity,
        selectedRegion,
      ];
}
