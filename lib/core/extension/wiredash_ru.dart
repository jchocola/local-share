import 'package:wiredash/assets/l10n/wiredash_localizations_en.g.dart';

class WiredashLocalizationsRussian extends WiredashLocalizationsEn {
  WiredashLocalizationsRussian() : super('ru');

 @override
  String get feedbackStep1MessageTitle => 'Отправьте нам ваш отзыв';

  @override
  String get feedbackStep1MessageBreadcrumbTitle => 'Сообщение';

  @override
  String get feedbackStep1MessageDescription =>
      'Добавьте краткое описание того, с чем вы столкнулись';

  @override
  String get feedbackStep1MessageHint =>
      'Например, возникает неизвестная ошибка при смене аватара...';

  @override
  String get feedbackStep1MessageErrorMissingMessage => 'Пожалуйста, добавьте сообщение';

  @override
  String get feedbackStep2LabelsTitle =>
      'Какая категория лучше всего описывает ваш отзыв?';

  @override
  String get feedbackStep2LabelsBreadcrumbTitle => 'Категории';

  @override
  String get feedbackStep2LabelsDescription =>
      'Правильный выбор категории помогает нам определить проблему и направить отзыв нужной команде';

  @override
  String get feedbackStep3ScreenshotOverviewTitle =>
      'Добавить скриншоты для наглядности?';

  @override
  String get feedbackStep3ScreenshotOverviewBreadcrumbTitle => 'Скриншоты';

  @override
  String get feedbackStep3ScreenshotOverviewDescription =>
      'Вы сможете перейти в нужное место в приложении и сделать снимок экрана';

  @override
  String get feedbackStep3ScreenshotOverviewSkipButton => 'Пропустить';

  @override
  String get feedbackStep3ScreenshotOverviewAddScreenshotButton =>
      'Добавить скриншот';

  @override
  String get feedbackStep3ScreenshotBarNavigateTitle => 'Сделать скриншот';

  @override
  String get feedbackStep3ScreenshotBottomBarTitle =>
      'Добавьте скриншот для большего контекста';

  @override
  String get feedbackStep3ScreenshotBarDrawTitle =>
      'Рисуйте на экране, чтобы добавить пояснения';

  @override
  String get feedbackStep3ScreenshotBarDrawUndoButton => 'Отменить';

  @override
  String get feedbackStep3ScreenshotBarCaptureButton => 'Сделать снимок';

  @override
  String get feedbackStep3ScreenshotBarSaveButton => 'Сохранить';

  @override
  String get feedbackStep3ScreenshotBarOkButton => 'Готово';

  @override
  String get feedbackStep3GalleryTitle => 'Прикреплённые скриншоты';

  @override
  String get feedbackStep3GalleryBreadcrumbTitle => 'Скриншоты';

  @override
  String get feedbackStep3GalleryDescription =>
      'Вы можете добавить ещё скриншотов, чтобы мы лучше поняли проблему.';

  @override
  String get feedbackStep4EmailTitle => 'Получать обновления по вашей проблеме на email';

  @override
  String get feedbackStep4EmailBreadcrumbTitle => 'Контакт';

  @override
  String get feedbackStep4EmailDescription =>
      'Укажите ваш адрес электронной почты ниже или оставьте поле пустым';

  @override
  String get feedbackStep4EmailInvalidEmail =>
      'Это не похоже на корректный email-адрес. Вы можете оставить поле пустым.';

  @override
  String get feedbackStep4EmailInputHint => 'mail@example.com';

  @override
  String get feedbackStep6SubmitTitle => 'Отправить отзыв';

  @override
  String get feedbackStep6SubmitBreadcrumbTitle => 'Отправка';

  @override
  String get feedbackStep6SubmitDescription =>
      'Пожалуйста, проверьте всю информацию перед отправкой.\nВы можете вернуться назад и изменить отзыв в любой момент.';

  @override
  String get feedbackStep6SubmitSubmitButton => 'Отправить';

  @override
  String get feedbackStep6SubmitSubmitShowDetailsButton => 'Показать детали';

  @override
  String get feedbackStep6SubmitSubmitHideDetailsButton => 'Скрыть детали';

  @override
  String get feedbackStep6SubmitSubmitDetailsTitle => 'Детали отзыва';

  @override
  String get feedbackStep7SubmissionInFlightMessage =>
      'Отправка вашего отзыва';

  @override
  String get feedbackStep7SubmissionSuccessMessage =>
      'Спасибо за ваш отзыв!';

  @override
  String get feedbackStep7SubmissionErrorMessage =>
      'Не удалось отправить отзыв';

  @override
  String get feedbackStep7SubmissionOpenErrorButton =>
      'Нажмите, чтобы увидеть детали ошибки';

  @override
  String get feedbackStep7SubmissionRetryButton => 'Повторить';

  @override
  String feedbackStepXOfY(int current, int total) {
    return 'Шаг $current из $total';
  }

  @override
  String get feedbackDiscardButton => 'Отменить отзыв';

  @override
  String get feedbackDiscardConfirmButton => 'Вы уверены? Отменить!';

  @override
  String get feedbackNextButton => 'Далее';

  @override
  String get feedbackBackButton => 'Назад';

  @override
  String get feedbackCloseButton => 'Закрыть';

  @override
  String get promoterScoreStep1Question =>
      'Насколько вероятно, что вы порекомендуете нас?';

  @override
  String get promoterScoreStep1Description =>
      '0 = Маловероятно, 10 = Определённо порекомендую';

  @override
  String get promoterScoreStep2MessageTitle =>
      'Насколько вероятно, что вы порекомендуете нас друзьям или семье?';

  @override
  String promoterScoreStep2MessageDescription(int rating) {
    return 'Не могли бы вы подробнее рассказать, почему вы выбрали оценку $rating? Этот шаг необязателен.';
  }

  @override
  String get promoterScoreStep2MessageHint =>
      'Было бы здорово, если бы вы улучшили...';

  @override
  String get promoterScoreStep3ThanksMessagePromoters =>
      'Спасибо за вашу оценку!';

  @override
  String get promoterScoreStep3ThanksMessagePassives =>
      'Спасибо за вашу оценку!';

  @override
  String get promoterScoreStep3ThanksMessageDetractors =>
      'Спасибо за вашу оценку!';

  @override
  String get promoterScoreNextButton => 'Далее';

  @override
  String get promoterScoreBackButton => 'Назад';

  @override
  String get promoterScoreSubmitButton => 'Отправить';

  @override
  String get backdropReturnToApp => 'Вернуться в приложение';
}
