// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(chunkSize) => "${chunkSize} MB";

  static String m1(files) => "${files} Файлов";

  static String m2(files) => "(${files}) файлов готово к раздаче на сервере.";

  static String m3(receivedFilesCount) =>
      "Полученные файлы (${receivedFilesCount})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("О приложении"),
    "appereanceSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки внешнего вида",
    ),
    "applicationTheme": MessageLookupByLibrary.simpleMessage("Тема приложения"),
    "autoAcceptSmallFiles": MessageLookupByLibrary.simpleMessage(
      "Автоприем мелких файлов",
    ),
    "automaticallyAcceptTransfersUnder10mbFromKnownDevices":
        MessageLookupByLibrary.simpleMessage(
          "Автоматически принимать передачи до 10 МБ с известных устройств.",
        ),
    "becomeVisible": MessageLookupByLibrary.simpleMessage("Стать видимым"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "chooseBetweenLightDark": MessageLookupByLibrary.simpleMessage(
      "Выберите между светлой, темной",
    ),
    "chunkSize": MessageLookupByLibrary.simpleMessage("Размер блока"),
    "chunksizeMb": m0,
    "confirmTransfer": MessageLookupByLibrary.simpleMessage(
      "Подтвердить передачу",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Темная"),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("Папка загрузки"),
    "filesFiles": m1,
    "filesFilesReadyToServeInServer": m2,
    "filesWillBeTransferredOverLocalNetwork":
        MessageLookupByLibrary.simpleMessage(
          "Файлы будут переданы по локальной сети",
        ),
    "fromCamera": MessageLookupByLibrary.simpleMessage("С камеры"),
    "fromGallery": MessageLookupByLibrary.simpleMessage("Из галереи"),
    "ifDisabledDuplicateFilesAreRenamedAutomatically":
        MessageLookupByLibrary.simpleMessage(
          "Если отключено, повторяющиеся файлы переименовываются автоматически.",
        ),
    "ipAddress": MessageLookupByLibrary.simpleMessage("IP-адрес"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "legalInformation": MessageLookupByLibrary.simpleMessage(
      "Юридическая информация",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Светлая"),
    "listeningForRequests": MessageLookupByLibrary.simpleMessage(
      "Ожидание запросов",
    ),
    "makeSureThatYouAndTheRecipientAreOnThe":
        MessageLookupByLibrary.simpleMessage(
          "Убедитесь, что вы и получатель находитесь в одной сети!",
        ),
    "noInternetConnectionRequired": MessageLookupByLibrary.simpleMessage(
      "Подключение к интернету не требуется",
    ),
    "notFoundsReceiverTrySendViaServer": MessageLookupByLibrary.simpleMessage(
      "Не нашли получателя? Попробуйте отправить через сервер",
    ),
    "openServer": MessageLookupByLibrary.simpleMessage("Открыть сервер"),
    "overwriteExistingFiles": MessageLookupByLibrary.simpleMessage(
      "Перезаписывать существующие файлы",
    ),
    "pleaseSelectFilesToSend": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите файлы для отправки...",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Порт"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "receive": MessageLookupByLibrary.simpleMessage("Получить"),
    "receiveAlertsForIncomingRequestsAndCompletions":
        MessageLookupByLibrary.simpleMessage(
          "Получать оповещения о входящих запросах и завершении передач.",
        ),
    "receivedFilesReceivedfilescount": m3,
    "resetDeviceId": MessageLookupByLibrary.simpleMessage(
      "Сбросить ID устройства",
    ),
    "searchingForDevices": MessageLookupByLibrary.simpleMessage(
      "Поиск устройств...",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Выбрать файл"),
    "selectMultipleFiles": MessageLookupByLibrary.simpleMessage(
      "Выбрать несколько файлов",
    ),
    "selectPhoto": MessageLookupByLibrary.simpleMessage("Выбрать фото"),
    "send": MessageLookupByLibrary.simpleMessage("Отправить"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Отправить отзыв"),
    "sendFiles": MessageLookupByLibrary.simpleMessage("Отправить"),
    "server": MessageLookupByLibrary.simpleMessage("Сервер"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "show": MessageLookupByLibrary.simpleMessage("Показать"),
    "stop": MessageLookupByLibrary.simpleMessage("Остановить"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Условия использования",
    ),
    "theMoreTheFasterTheLessTheBetter": MessageLookupByLibrary.simpleMessage(
      "Чем больше- тем быстрее!\nЧем меньше- тем надежнее!",
    ),
    "theSizeOfAPieceOfDataDuringTransferring":
        MessageLookupByLibrary.simpleMessage(
          "Размер фрагмента данных во время передачи.",
        ),
    "transferInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о передаче",
    ),
    "transferNotifications": MessageLookupByLibrary.simpleMessage(
      "Уведомления о передаче",
    ),
    "transferSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки передачи",
    ),
    "transferSpeedDependsOnNetworkQualityAndSettedChunkSize":
        MessageLookupByLibrary.simpleMessage(
          "Скорость передачи зависит от качества сети и установленного размера блока",
        ),
    "transferViaServer": MessageLookupByLibrary.simpleMessage(
      "Передача через сервер",
    ),
    "turnOnVisibilityToAllowOtherDevicesToDiscoverAnd":
        MessageLookupByLibrary.simpleMessage(
          "Включите видимость, чтобы другие устройства могли обнаружить и отправить вам файлы",
        ),
    "usingThisMethodYouCanExchangeDataWithAnyDevices":
        MessageLookupByLibrary.simpleMessage(
          "Используя этот метод, вы можете обмениваться данными с любыми устройствами под разными ОС.",
        ),
    "waitingForIncomingConnections": MessageLookupByLibrary.simpleMessage(
      "Ожидание входящих соединений...",
    ),
    "whereReceivedFilesAreSaved": MessageLookupByLibrary.simpleMessage(
      "Куда сохраняются полученные файлы.",
    ),
    "youAreInvisibleToOtherDevices": MessageLookupByLibrary.simpleMessage(
      "Вы невидимы для других устройств!",
    ),
    "yourDeviceIsReadyToReceiveFilesOtherDevicesCan":
        MessageLookupByLibrary.simpleMessage(
          "Ваше устройство готово к приему файлов. Другие устройства могут отправлять вам файлы, когда вы видимы в сети.",
        ),
  };
}
