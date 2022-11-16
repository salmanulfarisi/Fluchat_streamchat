import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

const streamKey = "rkxhgqc5wf2x";
const streamSecret =
    "vzcbt7thjw6tck28zw3a7qfyt9uqmjv58bstey3mhqw7z33tzd7gx5k5u6nyycr8";

var logger = log.Logger();

/// Extensions can be used to add functionality to the SDK.
extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
