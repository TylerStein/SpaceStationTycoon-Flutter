class IDProvider {
  int poolMax;
  final int poolChunkSize;
  final List<ID> pool;

  IDProvider({
    List<ID> initialPool,
    int poolChunkSizeOverride = 100,
  }) :
    poolChunkSize = poolChunkSizeOverride,
    pool = initialPool ?? List<ID>();

  ID unique() {
    if (pool.isEmpty) {
      addPoolChunk();
    }

    return pool.removeLast();
  }

  void recycle(ID id) {
    pool.add(id);
  }

  void addPoolChunk() {
    pool.addAll(
      List.generate(poolChunkSize, (index) => ID(poolMax + index)),
    );
    poolMax += poolChunkSize;
  }
  
  @override
  int get hashCode => poolMax.hashCode ^ poolChunkSize.hashCode ^ pool.length.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is IDProvider &&
    other.poolMax == poolMax &&
    other.poolChunkSize == poolChunkSize &&
    other.pool.length == pool.length;
}

class ID {
  int _id;
  int get id => _id;

  ID(this._id);

  @override
  int get hashCode => _id.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is ID &&
    other._id == _id;
}