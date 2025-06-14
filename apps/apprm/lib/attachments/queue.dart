import 'dart:async';
import 'dart:io';

import 'package:apprm/configs/supabase.dart';
import 'package:powersync/powersync.dart';
import 'package:powersync_attachments_helper/powersync_attachments_helper.dart';

import 'remote_storage_adapter.dart';

/// Global reference to the queue
late final PhotoAttachmentQueue attachmentQueue;
final remoteStorage = SupabaseStorageAdapter();

/// Function to handle errors when downloading attachments
/// Return false if you want to archive the attachment
Future<bool> onDownloadError(Attachment attachment, Object exception) async {
  if (exception.toString().contains('Object not found')) {
    return false;
  }
  return true;
}

class PhotoAttachmentQueue extends AbstractAttachmentQueue {
  PhotoAttachmentQueue(db, remoteStorage)
      : super(
            db: db,
            remoteStorage: remoteStorage,
            onDownloadError: onDownloadError);

  @override
  init() async {
    if (SupabaseConfig.storageBucket.isEmpty) {
      log.info(
          'No Supabase bucket configured, skip setting up PhotoAttachmentQueue watches');
      return;
    }

    await super.init();
  }

  @override
  Future<Attachment> saveFile(String fileId, int size,
      {mediaType = 'image/jpeg', String folder = ''}) async {
    final path = folder.isNotEmpty ? '$folder/$fileId' : fileId;
    String filename = '$path.jpg';

    Attachment photoAttachment = Attachment(
      id: fileId,
      filename: filename,
      state: AttachmentState.queuedUpload.index,
      mediaType: mediaType,
      localUri: getLocalFilePathSuffix(filename),
      size: size,
    );

    return attachmentsService.saveAttachment(photoAttachment);
  }

  @override
  Future<Attachment> deleteFile(String fileId, {String folder = ''}) async {
    final path = folder.isNotEmpty ? '$folder/$fileId' : fileId;
    String filename = '$path.jpg';

    Attachment photoAttachment = Attachment(
        id: fileId,
        filename: filename,
        state: AttachmentState.queuedDelete.index);

    return attachmentsService.saveAttachment(photoAttachment);
  }

  @override
  StreamSubscription<void> watchIds({String fileExtension = 'jpg'}) {
    log.info('Watching screen and element photos...');
    return db.watch('''
      SELECT photo_id, 'screens' AS folder FROM screen_photos
        WHERE photo_id IS NOT NULL
      UNION
      SELECT photo_id, 'elements' AS folder FROM element_photos
        WHERE photo_id IS NOT NULL
    ''').map((results) {
      return results
          .map((row) => {
                'id': row['photo_id'] as String,
                'folder': row['folder'] as String
              })
          .toList();
    }).listen((rows) async {
      List<String> idsInQueue = await attachmentsService.getAttachmentIds();
      List<Attachment> attachments = [];
      for (final row in rows) {
        final id = row['id'] as String;
        if (idsInQueue.contains(id)) continue;
        final folder = row['folder'] as String;
        final filename =
            '${folder.isNotEmpty ? '$folder/' : ''}$id.$fileExtension';
        final localUri = await getLocalUri(filename);
        if (!await File(localUri).exists()) {
          attachments.add(Attachment(
              id: id,
              filename: filename,
              state: AttachmentState.queuedDownload.index));
        }
      }
      await attachmentsService.saveAttachments(attachments);
    });
  }
}

initializeAttachmentQueue(PowerSyncDatabase db) async {
  attachmentQueue = PhotoAttachmentQueue(db, remoteStorage);
  await attachmentQueue.init();
}
