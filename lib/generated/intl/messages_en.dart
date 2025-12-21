// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(chunkSize) => "${chunkSize} MB";

  static String m1(files) => "${files} Files";

  static String m2(files) => "(${files}) files ready to serve in server.";

  static String m3(receivedFilesCount) =>
      "Received files (${receivedFilesCount})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("About App"),
    "appereanceSettings": MessageLookupByLibrary.simpleMessage(
      "Appereance Settings",
    ),
    "applicationTheme": MessageLookupByLibrary.simpleMessage(
      "Application Theme",
    ),
    "autoAcceptSmallFiles": MessageLookupByLibrary.simpleMessage(
      "Auto Accept Small Files",
    ),
    "automaticallyAcceptTransfersUnder10mbFromKnownDevices":
        MessageLookupByLibrary.simpleMessage(
          "Automatically accept transfers under 10MB from known devices.",
        ),
    "becomeVisible": MessageLookupByLibrary.simpleMessage("Become Visible"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "chooseBetweenLightDark": MessageLookupByLibrary.simpleMessage(
      "Choose between light, dark",
    ),
    "chunkSize": MessageLookupByLibrary.simpleMessage("Chunk Size"),
    "chunksizeMb": m0,
    "closedServer": MessageLookupByLibrary.simpleMessage("Closed server"),
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("Confirm Transfer"),
    "connectToWifiOrYourPersonalInternetConnection":
        MessageLookupByLibrary.simpleMessage(
          "Connect to Wi-Fi or your personal internet connection.",
        ),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Download Location",
    ),
    "filesFiles": m1,
    "filesFilesReadyToServeInServer": m2,
    "filesWillBeTransferredOverLocalNetwork":
        MessageLookupByLibrary.simpleMessage(
          "Files will be transferred over local network",
        ),
    "fromCamera": MessageLookupByLibrary.simpleMessage("From camera"),
    "fromGallery": MessageLookupByLibrary.simpleMessage("From gallery"),
    "ifDisabledDuplicateFilesAreRenamedAutomatically":
        MessageLookupByLibrary.simpleMessage(
          "If disabled, duplicate files are renamed automatically.",
        ),
    "ipAddress": MessageLookupByLibrary.simpleMessage("IP Address"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "legalInformation": MessageLookupByLibrary.simpleMessage(
      "Legal Information",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "listeningForRequests": MessageLookupByLibrary.simpleMessage(
      "Listening for requests",
    ),
    "localshare": MessageLookupByLibrary.simpleMessage("LocalShare"),
    "lookingForEachOther": MessageLookupByLibrary.simpleMessage(
      "Looking for each other",
    ),
    "makeSureThatYouAndTheRecipientAreOnThe":
        MessageLookupByLibrary.simpleMessage(
          "Make sure that you and the recipient are on the same network!",
        ),
    "noInternetConnectionRequired": MessageLookupByLibrary.simpleMessage(
      "No internet connection required",
    ),
    "notFoundsReceiverTrySendViaServer": MessageLookupByLibrary.simpleMessage(
      "Not founds receiver? Try send via server",
    ),
    "openAppSetting": MessageLookupByLibrary.simpleMessage("Open App Setting"),
    "openServer": MessageLookupByLibrary.simpleMessage("Open Server"),
    "openWifiSettings": MessageLookupByLibrary.simpleMessage(
      "Open WiFi settings",
    ),
    "openedServer": MessageLookupByLibrary.simpleMessage("Opened server!"),
    "overwriteExistingFiles": MessageLookupByLibrary.simpleMessage(
      "Overwrite Existing Files",
    ),
    "pleaseSelectFilesToSend": MessageLookupByLibrary.simpleMessage(
      "Please select files to send...",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "receive": MessageLookupByLibrary.simpleMessage("Receive"),
    "receiveAlertsForIncomingRequestsAndCompletions":
        MessageLookupByLibrary.simpleMessage(
          "Receive alerts for incoming requests and completions.",
        ),
    "receivedFilesReceivedfilescount": m3,
    "resetDeviceId": MessageLookupByLibrary.simpleMessage("Reset Device ID"),
    "searchingForDevices": MessageLookupByLibrary.simpleMessage(
      "Searching for devices...",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Select File"),
    "selectMultipleFiles": MessageLookupByLibrary.simpleMessage(
      "Select Multiple Files",
    ),
    "selectPhoto": MessageLookupByLibrary.simpleMessage("Select Photo"),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Send Feedback"),
    "sendFiles": MessageLookupByLibrary.simpleMessage("Send Files"),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "startDiscovering": MessageLookupByLibrary.simpleMessage(
      "Start Discovering",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "theMoreTheFasterTheLessTheBetter": MessageLookupByLibrary.simpleMessage(
      "The more, the faster. The less, the better!",
    ),
    "theSizeOfAPieceOfDataDuringTransferring":
        MessageLookupByLibrary.simpleMessage(
          "The size of a piece of data during transferring.",
        ),
    "transferInfo": MessageLookupByLibrary.simpleMessage("Transfer Info"),
    "transferNotifications": MessageLookupByLibrary.simpleMessage(
      "Transfer Notifications",
    ),
    "transferSettings": MessageLookupByLibrary.simpleMessage(
      "Transfer Settings",
    ),
    "transferSpeedDependsOnNetworkQualityAndSettedChunkSize":
        MessageLookupByLibrary.simpleMessage(
          "Transfer speed depends on network quality and setted chunk size",
        ),
    "transferViaServer": MessageLookupByLibrary.simpleMessage(
      "Transfer via Server",
    ),
    "transferringFilesBetweenDevicesnbetweenOperatingSystems":
        MessageLookupByLibrary.simpleMessage(
          "Transferring files between devices.\\nBetween operating systems.",
        ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "turnOnVisibilityToAllowOtherDevicesToDiscoverAnd":
        MessageLookupByLibrary.simpleMessage(
          "Turn on visibility to allow other devices to discover and send files to you",
        ),
    "usingThisMethodYouCanExchangeDataWithAnyDevices":
        MessageLookupByLibrary.simpleMessage(
          "Using this method, you can exchange data with any devices running different OS.",
        ),
    "waitingForIncomingConnections": MessageLookupByLibrary.simpleMessage(
      "Waiting for incoming connections...",
    ),
    "weFoundSomeone": MessageLookupByLibrary.simpleMessage("We found someone!"),
    "whereReceivedFilesAreSaved": MessageLookupByLibrary.simpleMessage(
      "Where received files are saved.",
    ),
    "wifiNearbyServiceDenied": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi Nearby Service Denied",
    ),
    "wifiNotConnected": MessageLookupByLibrary.simpleMessage(
      "Wi-Fi Not Connected",
    ),
    "yohooo": MessageLookupByLibrary.simpleMessage("Yohooo"),
    "youAreInvisibleToOtherDevices": MessageLookupByLibrary.simpleMessage(
      "You are invisible to other devices!",
    ),
    "youCanOpenServerForTransferingFilesNow":
        MessageLookupByLibrary.simpleMessage(
          "You can open server for transfering files now!",
        ),
    "youCanStillTransferFiles": MessageLookupByLibrary.simpleMessage(
      "You can still transfer files.",
    ),
    "youCantSeeOtherstheyCantSeeYou": MessageLookupByLibrary.simpleMessage(
      "You can\'t see others.They can\'t see you.",
    ),
    "yourDeviceIsReadyToReceiveFilesOtherDevicesCan":
        MessageLookupByLibrary.simpleMessage(
          "Your device is ready to receive files. Other devices can send files to you when you\'re visible on the network.",
        ),
  };
}
