import 'package:wiredash/assets/l10n/wiredash_localizations_en.g.dart';

class WiredashLocalizationsVietnamese extends WiredashLocalizationsEn {
  WiredashLocalizationsVietnamese() : super('vi');

@override
  String get feedbackStep1MessageTitle => 'Gửi phản hồi cho chúng tôi';

  @override
  String get feedbackStep1MessageBreadcrumbTitle => 'Soạn nội dung';

  @override
  String get feedbackStep1MessageDescription =>
      'Thêm mô tả ngắn gọn về sự cố bạn gặp phải';

  @override
  String get feedbackStep1MessageHint =>
      'Ví dụ: Có lỗi không xác định khi tôi cố gắng đổi ảnh đại diện...';

  @override
  String get feedbackStep1MessageErrorMissingMessage => 'Vui lòng thêm nội dung phản hồi';

  @override
  String get feedbackStep2LabelsTitle =>
      'Nhãn nào mô tả đúng nhất phản hồi của bạn?';

  @override
  String get feedbackStep2LabelsBreadcrumbTitle => 'Nhãn phân loại';

  @override
  String get feedbackStep2LabelsDescription =>
      'Chọn đúng danh mục giúp chúng tôi xác định vấn đề và chuyển phản hồi của bạn đến đúng bộ phận';

  @override
  String get feedbackStep3ScreenshotOverviewTitle =>
      'Thêm ảnh chụp màn hình để minh họa?';

  @override
  String get feedbackStep3ScreenshotOverviewBreadcrumbTitle => 'Ảnh chụp màn hình';

  @override
  String get feedbackStep3ScreenshotOverviewDescription =>
      'Bạn có thể điều hướng trong ứng dụng và chọn thời điểm chụp ảnh màn hình';

  @override
  String get feedbackStep3ScreenshotOverviewSkipButton => 'Bỏ qua';

  @override
  String get feedbackStep3ScreenshotOverviewAddScreenshotButton =>
      'Thêm ảnh chụp màn hình';

  @override
  String get feedbackStep3ScreenshotBarNavigateTitle => 'Chụp ảnh màn hình';

  @override
  String get feedbackStep3ScreenshotBottomBarTitle =>
      'Thêm ảnh chụp màn hình để cung cấp ngữ cảnh rõ hơn';

  @override
  String get feedbackStep3ScreenshotBarDrawTitle =>
      'Vẽ lên màn hình để làm nổi bật chi tiết';

  @override
  String get feedbackStep3ScreenshotBarDrawUndoButton => 'Hoàn tác';

  @override
  String get feedbackStep3ScreenshotBarCaptureButton => 'Chụp';

  @override
  String get feedbackStep3ScreenshotBarSaveButton => 'Lưu';

  @override
  String get feedbackStep3ScreenshotBarOkButton => 'Đồng ý';

  @override
  String get feedbackStep3GalleryTitle => 'Ảnh chụp màn hình đã đính kèm';

  @override
  String get feedbackStep3GalleryBreadcrumbTitle => 'Ảnh chụp màn hình';

  @override
  String get feedbackStep3GalleryDescription =>
      'Bạn có thể thêm nhiều ảnh chụp màn hình hơn để giúp chúng tôi hiểu rõ vấn đề của bạn.';

  @override
  String get feedbackStep4EmailTitle => 'Nhận cập nhật về vấn đề của bạn qua email';

  @override
  String get feedbackStep4EmailBreadcrumbTitle => 'Liên hệ';

  @override
  String get feedbackStep4EmailDescription =>
      'Thêm địa chỉ email của bạn bên dưới hoặc để trống';

  @override
  String get feedbackStep4EmailInvalidEmail =>
      'Địa chỉ email này có vẻ không hợp lệ. Bạn có thể để trống ô này.';

  @override
  String get feedbackStep4EmailInputHint => 'mail@example.com';

  @override
  String get feedbackStep6SubmitTitle => 'Gửi phản hồi';

  @override
  String get feedbackStep6SubmitBreadcrumbTitle => 'Gửi';

  @override
  String get feedbackStep6SubmitDescription =>
      'Vui lòng kiểm tra lại tất cả thông tin trước khi gửi.\nBạn có thể quay lại để chỉnh sửa phản hồi bất cứ lúc nào.';

  @override
  String get feedbackStep6SubmitSubmitButton => 'Gửi';

  @override
  String get feedbackStep6SubmitSubmitShowDetailsButton => 'Hiện chi tiết';

  @override
  String get feedbackStep6SubmitSubmitHideDetailsButton => 'Ẩn chi tiết';

  @override
  String get feedbackStep6SubmitSubmitDetailsTitle => 'Chi tiết phản hồi';

  @override
  String get feedbackStep7SubmissionInFlightMessage =>
      'Đang gửi phản hồi của bạn';

  @override
  String get feedbackStep7SubmissionSuccessMessage =>
      'Cảm ơn phản hồi của bạn!';

  @override
  String get feedbackStep7SubmissionErrorMessage =>
      'Gửi phản hồi không thành công';

  @override
  String get feedbackStep7SubmissionOpenErrorButton =>
      'Nhấn để xem chi tiết lỗi';

  @override
  String get feedbackStep7SubmissionRetryButton => 'Thử lại';

  @override
  String feedbackStepXOfY(int current, int total) {
    return 'Bước $current/$total';
  }

  @override
  String get feedbackDiscardButton => 'Hủy phản hồi';

  @override
  String get feedbackDiscardConfirmButton => 'Xác nhận? Hủy bỏ!';

  @override
  String get feedbackNextButton => 'Tiếp theo';

  @override
  String get feedbackBackButton => 'Quay lại';

  @override
  String get feedbackCloseButton => 'Đóng';

  @override
  String get promoterScoreStep1Question =>
      'Bạn có khả năng giới thiệu chúng tôi cho người khác đến mức nào?';

  @override
  String get promoterScoreStep1Description =>
      '0 = Không có khả năng, 10 = Rất có khả năng';

  @override
  String get promoterScoreStep2MessageTitle =>
      'Bạn có khả năng giới thiệu chúng tôi cho bạn bè và người thân đến mức nào?';

  @override
  String promoterScoreStep2MessageDescription(int rating) {
    return 'Bạn có thể cho biết thêm lý do tại sao bạn chọn $rating? Bước này là tùy chọn.';
  }

  @override
  String get promoterScoreStep2MessageHint =>
      'Sẽ thật tuyệt nếu bạn có thể cải thiện...';

  @override
  String get promoterScoreStep3ThanksMessagePromoters =>
      'Cảm ơn đánh giá của bạn!';

  @override
  String get promoterScoreStep3ThanksMessagePassives =>
      'Cảm ơn đánh giá của bạn!';

  @override
  String get promoterScoreStep3ThanksMessageDetractors =>
      'Cảm ơn đánh giá của bạn!';

  @override
  String get promoterScoreNextButton => 'Tiếp theo';

  @override
  String get promoterScoreBackButton => 'Quay lại';

  @override
  String get promoterScoreSubmitButton => 'Gửi';

  @override
  String get backdropReturnToApp => 'Quay lại ứng dụng';
}