part of 'favorite_cubit.dart';

///Implemented my Bloc like a cubit without using event as a state to make my code simpler
///and to show you another method of implementation

class FavoriteState extends Equatable{
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteInitialized extends FavoriteState {}

class FavoriteLoadInProgress extends FavoriteState {}

class FavoriteLoadSuccess extends FavoriteState {

  final List<ImageModel> favoriteImages;

  const FavoriteLoadSuccess([this.favoriteImages = const []]);
  @override
  List<Object> get props => [favoriteImages];

}

class FavoriteLoadFailure extends FavoriteState {}

// class FavoriteImageSaveSuccess extends FavoriteState {}
//
// class FavoriteSaveFailure extends FavoriteState {}





///
/// Old implementation
///
/// enum FavoriteStatus {initial, loading, success, failure}
///
/// class FavoriteState extends Equatable{
///   const FavoriteState(
///       this.status = ImageStatus,
///       this.favoritelist,
///       );
///   final FavoriteState status;
///   final List<ImageModel> favoritelist;
///   @override
///   List<Object> get props => [status, favoritelist];
/// }