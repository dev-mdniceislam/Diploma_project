import 'package:file_picker/file_picker.dart';

import '../../domain/entities/job_circular.dart';

/// Only place that touches `file_picker` — swap the package here if needed.
Future<AttachedFile?> pickDocument({
  List<String> extensions = const ['pdf'],
}) async {
  final f = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: extensions,
  );
  if (f == null) return null;

  final bytes = await f.readAsBytes();
  return AttachedFile(name: f.name, sizeBytes: bytes.length, bytes: bytes);
}
