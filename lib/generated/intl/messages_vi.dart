// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(buildDate) => "Ngày build: ${buildDate}";

  static String m1(chunkSize) => "${chunkSize} MB";

  static String m2(developerName) => "Nhà phát triển: ${developerName}";

  static String m3(files) => "${files} Tệp tin";

  static String m4(files) =>
      "(${files}) tệp tin đã sẵn sàng để phục vụ trên server.";

  static String m5(receivedFilesCount) =>
      "Đã nhận (${receivedFilesCount}) tệp tin";

  static String m6(appVersion) => "Phiên bản: ${appVersion}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("Về Ứng dụng"),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Gửi - Nhận file nội bộ",
    ),
    "appereanceSettings": MessageLookupByLibrary.simpleMessage(
      "Cài đặt giao diện",
    ),
    "applicationTheme": MessageLookupByLibrary.simpleMessage("Chủ đề ứng dụng"),
    "autoAcceptSmallFiles": MessageLookupByLibrary.simpleMessage(
      "Tự động chấp nhận các tệp nhỏ",
    ),
    "automaticallyAcceptTransfersUnder10mbFromKnownDevices":
        MessageLookupByLibrary.simpleMessage(
          "Tự động chấp nhận các giao dịch chuyển khoản dưới 10MB từ các thiết bị đã biết.",
        ),
    "becomeVisible": MessageLookupByLibrary.simpleMessage("Mở cổng tín hiệu"),
    "buildDateBuilddate": m0,
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "chooseBetweenLightDark": MessageLookupByLibrary.simpleMessage(
      "Chọn giữa sáng, tối",
    ),
    "chunkSize": MessageLookupByLibrary.simpleMessage("Kích thước khối"),
    "chunksizeMb": m1,
    "confirmTransfer": MessageLookupByLibrary.simpleMessage("Xác nhận chuyển"),
    "dark": MessageLookupByLibrary.simpleMessage("Tối"),
    "developerDevelopername": m2,
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Vị trí tải xuống",
    ),
    "filesFiles": m3,
    "filesFilesReadyToServeInServer": m4,
    "filesWillBeTransferredOverLocalNetwork":
        MessageLookupByLibrary.simpleMessage(
          "Các tệp tin sẽ được chuyển qua mạng nội bộ.",
        ),
    "fromCamera": MessageLookupByLibrary.simpleMessage("Từ camera"),
    "fromGallery": MessageLookupByLibrary.simpleMessage("Từ gallery"),
    "ifDisabledDuplicateFilesAreRenamedAutomatically":
        MessageLookupByLibrary.simpleMessage(
          "Nếu tính năng này bị tắt, các tệp trùng lặp sẽ được đổi tên tự động.",
        ),
    "ipAddress": MessageLookupByLibrary.simpleMessage("Địa chỉ IP"),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "legalInformation": MessageLookupByLibrary.simpleMessage(
      "Thông tin pháp lý",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Sáng"),
    "listeningForRequests": MessageLookupByLibrary.simpleMessage(
      "Lắng nghe các yêu cầu",
    ),
    "localshare": MessageLookupByLibrary.simpleMessage("LocalShare"),
    "makeSureThatYouAndTheRecipientAreOnThe":
        MessageLookupByLibrary.simpleMessage(
          "Hãy đảm bảo rằng bạn và người nhận đang ở trên cùng một mạng!",
        ),
    "noInternetConnectionRequired": MessageLookupByLibrary.simpleMessage(
      "Không cần kết nối internet",
    ),
    "notFoundsReceiverTrySendViaServer": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy người nhận?\nHãy thử gửi qua máy chủ.",
    ),
    "openServer": MessageLookupByLibrary.simpleMessage("Mở Server"),
    "overwriteExistingFiles": MessageLookupByLibrary.simpleMessage(
      "Ghi đè lên các tệp hiện có",
    ),
    "pleaseSelectFilesToSend": MessageLookupByLibrary.simpleMessage(
      "Hãy chọn file để gửi...",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Cổng"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Chính sách bảo mật"),
    "receive": MessageLookupByLibrary.simpleMessage("Nhận"),
    "receiveAlertsForIncomingRequestsAndCompletions":
        MessageLookupByLibrary.simpleMessage(
          "Nhận thông báo về các yêu cầu đến và các tác vụ đã hoàn thành.",
        ),
    "receivedFilesReceivedfilescount": m5,
    "resetDeviceId": MessageLookupByLibrary.simpleMessage("Đổi Device ID"),
    "searchingForDevices": MessageLookupByLibrary.simpleMessage(
      "Tìm thiết bị để gửi...",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Chọn File"),
    "selectMultipleFiles": MessageLookupByLibrary.simpleMessage(
      "Chọn nhiều File",
    ),
    "selectPhoto": MessageLookupByLibrary.simpleMessage("Chọn Photo"),
    "send": MessageLookupByLibrary.simpleMessage("Gửi"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Gửi phản hồi"),
    "sendFiles": MessageLookupByLibrary.simpleMessage("Gửi tệp"),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "show": MessageLookupByLibrary.simpleMessage("Thêm"),
    "stop": MessageLookupByLibrary.simpleMessage("Ngừng"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Điều khoản dịch vụ",
    ),
    "theMoreTheFasterTheLessTheBetter": MessageLookupByLibrary.simpleMessage(
      "Càng lớn, càng nhanh. Càng bé, càng ổn định!",
    ),
    "theSizeOfAPieceOfDataDuringTransferring":
        MessageLookupByLibrary.simpleMessage(
          "Kích thước của một phần dữ liệu trong quá trình truyền tải.",
        ),
    "transferInfo": MessageLookupByLibrary.simpleMessage("Thông tin chuyển"),
    "transferNotifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
    "transferSettings": MessageLookupByLibrary.simpleMessage(
      "Cài đặt chuyển đổi",
    ),
    "transferSpeedDependsOnNetworkQualityAndSettedChunkSize":
        MessageLookupByLibrary.simpleMessage(
          "Tốc độ truyền tải phụ thuộc vào chất lượng mạng và kích thước khối đã thiết lập.",
        ),
    "transferViaServer": MessageLookupByLibrary.simpleMessage("Gửi qua Server"),
    "turnOnVisibilityToAllowOtherDevicesToDiscoverAnd":
        MessageLookupByLibrary.simpleMessage(
          "Bật tính năng hiển thị để cho phép các thiết bị khác phát hiện và gửi tệp tin cho bạn.",
        ),
    "usingThisMethodYouCanExchangeDataWithAnyDevices":
        MessageLookupByLibrary.simpleMessage(
          "Sử dụng phương pháp này, bạn có thể trao đổi dữ liệu với bất kỳ thiết bị nào chạy trên các hệ điều hành khác nhau.",
        ),
    "versionAppversion": m6,
    "waitingForIncomingConnections": MessageLookupByLibrary.simpleMessage(
      "Đang chờ kết nối đến...",
    ),
    "whereReceivedFilesAreSaved": MessageLookupByLibrary.simpleMessage(
      "Nơi lưu trữ các tệp đã nhận.",
    ),
    "youAreInvisibleToOtherDevices": MessageLookupByLibrary.simpleMessage(
      "Bạn không hiển thị cho các thiết bị khác!",
    ),
    "yourDeviceIsReadyToReceiveFilesOtherDevicesCan":
        MessageLookupByLibrary.simpleMessage(
          "Thiết bị của bạn đã sẵn sàng để nhận tệp tin. Các thiết bị khác có thể gửi tệp tin cho bạn khi thiết bị của bạn hiển thị trên mạng.",
        ),
  };
}
