
class TieredData<T> {
  TieredData();

  Map<int, T> _resourceByTier;
  Type get resourceType => T;

  T getForTier(int tier, { T Function(int index) orElse }) {
    if (_resourceByTier.containsKey(tier)) return _resourceByTier[tier];
    else if (orElse != null) return orElse(tier);
    else return null;
  }

  void setForTier(int tier, T value) {
    _resourceByTier[tier] = value;
  }

  @override
  int get hashCode => resourceType.hashCode ^ _resourceByTier.length.hashCode;

  @override
  operator ==(Object other) => 
    identical(this, other) ||
    other is TieredData
    && other.resourceType == resourceType
    && other._resourceByTier.length == _resourceByTier.length;
}
