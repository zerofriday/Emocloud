import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';

final aesAlgorithm = AesCbc.with256bits(
  macAlgorithm: Hmac.sha256(),
);


Future encryptFile(Map params) async {
  // read original file
  File selectedFile = File(params["file"]);
  var fileData = await selectedFile.readAsBytes();
  // encode key
  final secretKey =
      await aesAlgorithm.newSecretKeyFromBytes(utf8.encode(params["key"]));

  // encrypt file
  final secretBox = await aesAlgorithm.encrypt(
    fileData,
    secretKey: secretKey,
  );
  // save encrypted file
  File _outfile = File(params["outFile"]);
  await _outfile.writeAsBytes(secretBox.concatenation());
  return Future.value(true);
}

Future decryptFile(Map params) async {
  final secretKey =
      await aesAlgorithm.newSecretKeyFromBytes(utf8.encode(params["key"]));

  // read encrypted file
  File encryptedFile = File(params["file"]);
  final fileBytes = encryptedFile.readAsBytesSync();
  final _secretBox = SecretBox.fromConcatenation(
    fileBytes,
    nonceLength: 16,
    macLength: 32,
  );

  // Decrypt
  final clearText = await aesAlgorithm.decrypt(
    _secretBox,
    secretKey: secretKey,
  );

  File _outfile = File(params["outFile"]);
  await _outfile.writeAsBytes(clearText);
  return Future.value(true);
}
