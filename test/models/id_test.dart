import 'package:flutter_test/flutter_test.dart';
import 'package:space_station_tycoon/models/id.dart';

main() {
  group('Model.IDProvider', () {
    test('should provide incrementing IDs within the pool size without expanding it', () {
      IDProvider provider = IDProvider(
        initialPool: [],
        poolChunkSizeOverride: 1,
      );

      expect(provider.pool.isEmpty, true, reason: 'IDProvider pool should start empty');
      ID firstId = provider.unique();

      expect(firstId.id, 0, reason: 'IDProvider first ID should be 0');
    });

  });
}