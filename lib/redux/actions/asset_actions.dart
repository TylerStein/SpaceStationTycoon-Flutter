import 'package:space_station_tycoon/redux/state/asset_state.dart';

class LoadAssetsAction {}
class SetAssetStateAction {
  final AssetState state;
  SetAssetStateAction(this.state);
}