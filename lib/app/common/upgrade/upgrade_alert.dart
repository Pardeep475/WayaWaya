import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'upgrade_base.dart';
import 'upgrade_messages.dart';
import 'upgrader.dart';

/// A widget to display the upgrade dialog.
class UpgradeAlert extends UpgradeBase {
  /// The [child] contained by the widget.
  final Widget child;

  UpgradeAlert({
    Key key,
    AppcastConfiguration appcastConfig,
    UpgraderMessages messages,
    this.child,
    bool debugAlwaysUpgrade,
    bool debugDisplayOnce,
    bool debugLogging,
    Duration durationToAlertAgain,
    BoolCallback onIgnore,
    BoolCallback onLater,
    BoolCallback onUpdate,
    BoolCallback shouldPopScope,
    http.Client client,
    bool showIgnore,
    bool showLater,
    bool showReleaseNotes,
    bool canDismissDialog,
    String countryCode,
    String minAppVersion,
    UpgradeDialogStyle dialogStyle,
  }) : super(
          key: key,
          appcastConfig: appcastConfig,
          messages: messages,
          debugDisplayAlways: debugAlwaysUpgrade,
          debugDisplayOnce: debugDisplayOnce,
          debugLogging: debugLogging,
          durationToAlertAgain: durationToAlertAgain,
          onIgnore: onIgnore,
          onLater: onLater,
          onUpdate: onUpdate,
          shouldPopScope: shouldPopScope,
          client: client,
          showIgnore: showIgnore,
          showLater: showLater,
          showReleaseNotes: showReleaseNotes,
          canDismissDialog: canDismissDialog,
          countryCode: countryCode,
          minAppVersion: minAppVersion,
          dialogStyle: dialogStyle,
        );

  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (Upgrader().debugLogging) {
      print('upgrader: build UpgradeAlert');
    }

    return FutureBuilder(
        future: state.initialized,
        builder: (BuildContext context, AsyncSnapshot<bool> processed) {
          if (processed.connectionState == ConnectionState.done &&
              processed.data != null &&
              processed.data) {
            Upgrader().checkVersion(context: context);
          }
          return child;
        });
  }
}
