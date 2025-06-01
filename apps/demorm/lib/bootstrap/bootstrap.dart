import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:demorm/configs/supabase.dart';

import '../attachments/queue.dart';
import 'logging.dart';
import 'powersync.dart';

Future<void> bootstrap() async {
  setupLogging();

  await openDatabase();
  if (SupabaseConfig.storageBucket.isNotEmpty) {
    initializeAttachmentQueue(db);
  }

  CachedQuery.instance.configFlutter(
    config: QueryConfigFlutter(
      refetchOnConnection: true,
      refetchOnResume: true,
      cacheDuration: const Duration(seconds: 1),
      refetchDuration: const Duration(seconds: 1),
    ),
  );
}
