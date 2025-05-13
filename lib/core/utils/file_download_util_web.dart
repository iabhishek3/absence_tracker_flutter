// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';

class FileDownloadUtilPlatform {
  static void downloadString({
    required String content,
    required String fileName,
    String contentType = 'text/calendar;charset=utf-8',
  }) {
    debugPrint('Downloading file: $fileName');
    debugPrint('Content length: ${content.length}');
    debugPrint('Content type: $contentType');
    
    if (content.isEmpty) {
      debugPrint('Warning: Content is empty!');
      return;
    }

    // Convert the string to UTF-8 bytes
    final bytes = utf8.encode(content);
    
    // Create a Blob containing the data
    final blob = html.Blob([bytes], contentType);
    
    // Create a URL for the blob
    final url = html.Url.createObjectUrlFromBlob(blob);
    debugPrint('Created blob URL: $url');
    
    // Create a link element
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..style.display = 'none';
    
    // Add the link to the document
    html.document.body?.children.add(anchor);
    
    // Trigger download
    anchor.click();
    debugPrint('Triggered download');
    
    // Clean up
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}