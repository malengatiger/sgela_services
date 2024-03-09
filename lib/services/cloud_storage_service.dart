import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:sgela_services/data/branding.dart';
import 'package:sgela_services/data/sponsoree.dart';
import 'package:sgela_services/sgela_util/functions.dart';

class CloudStorageService {
  static const mm = '🍎🍎🍎🍎🍎🍎CloudStorageService';

  Future<String> uploadFileToStorage(
      {required File file, required String contentType}) async {
    pp('$mm File: ${((await file.length()) / 1024 / 1024).toStringAsFixed(2)} MB bytes');
    // Create the file metadata
    final metadata = SettableMetadata(contentType: contentType);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // Generate a unique filename for the uploaded file
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the file in Firebase Cloud Storage
    Reference storageRef = firebaseStorage.ref().child(fileName);

    // Upload the file to Firebase Cloud Storage
    UploadTask uploadTask = storageRef.putFile(file);
    uploadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          pp("$mm Upload is $progress% complete.");
          break;
        case TaskState.paused:
          pp("$mm Upload is paused.");
          break;
        case TaskState.canceled:
          pp("$mm Upload was canceled");
          break;
        case TaskState.error:
          throw Exception('File upload failed');
          break;
        case TaskState.success:
          pp("$mm Upload successful.");

          break;
      }
    });
    // Wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL of the uploaded file
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Set the expiration time for the download URL to 10 years from now
    DateTime expirationTime = DateTime.now().add(Duration(days: 365 * 10));
    await taskSnapshot.ref.updateMetadata(
      SettableMetadata(
        cacheControl:
            'public, max-age=${expirationTime.difference(DateTime.now()).inSeconds}',
      ),
    );
    //
    pp("$mm downloadUrl is $downloadUrl");
    return downloadUrl;
  }

  Future uploadBranding({
    required int organizationId,
    required String organizationName,
    required String tagLine,
    required String orgUrl,
    required int splashTimeInSeconds,
    required int colorIndex,
    required File? logoFile,
    required File? splashFile,
  }) async {
    pp('$mm Logo File: ${((await logoFile?.length())! / 1024 / 1024).toStringAsFixed(2)} MB bytes');

    String? logoUrl, splashUrl;
    if (logoFile != null) {
      logoUrl = await uploadFileToStorage(
          file: logoFile, contentType: getContentTypeFromFile(logoFile));
    }
    if (splashFile != null) {
      splashUrl = await uploadFileToStorage(
          file: splashFile, contentType: getContentTypeFromFile(splashFile));
    }
    Branding branding = Branding(organizationId: organizationId, id: DateTime.now().millisecondsSinceEpoch,
        date: DateTime.now().toUtc().toIso8601String(),
        logoUrl: logoUrl, splashUrl: splashUrl,
        tagLine: tagLine, organizationName: organizationName,
        organizationUrl: orgUrl,
        splashTimeInSeconds: splashTimeInSeconds,
        colorIndex: colorIndex, boxFit: 0, activeFlag: true);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // await firebaseStorage.
  }

  String getContentTypeFromFile(File file) {
    final mimeTypeData = lookupMimeType(file.path);
    if (mimeTypeData != null) {
      pp('$mm mimeType: $mimeTypeData');
      return mimeTypeData.split('/').last;
    }
    return '';
  }

  Future uploadProfile(
      {required Sponsoree sponsoree, required File profileImage}) async {
    // Implement the uploadProfile method here
  }
}
