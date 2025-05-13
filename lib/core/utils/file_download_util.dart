// Web implementation
import 'file_download_util_web.dart' if (dart.library.io) 'file_download_util_io.dart';

class FileDownloadUtil {
  static void downloadString({
    required String content,
    required String fileName,
    String contentType = 'text/calendar;charset=utf-8',
  }) {
    FileDownloadUtilPlatform.downloadString(
      content: content,
      fileName: fileName,
      contentType: contentType,
    );
  }
} 