// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Không nhập kí tự đặc biệt và số`
  String get validFullName {
    return Intl.message(
      'Không nhập kí tự đặc biệt và số',
      name: 'validFullName',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập đày đủ tên của bạn`
  String get validEnterFullName {
    return Intl.message(
      'Vui lòng nhập đày đủ tên của bạn',
      name: 'validEnterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại của bạn`
  String get validEnterPhoneNumber {
    return Intl.message(
      'Vui lòng nhập số điện thoại của bạn',
      name: 'validEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Không nhập kí tự đặc biệt và chữ`
  String get validPhone {
    return Intl.message(
      'Không nhập kí tự đặc biệt và chữ',
      name: 'validPhone',
      desc: '',
      args: [],
    );
  }

  /// `Không nhập dưới 10 số và không vượt quá 11 số`
  String get validPhoneNumber {
    return Intl.message(
      'Không nhập dưới 10 số và không vượt quá 11 số',
      name: 'validPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu của bạn`
  String get validEnterPass {
    return Intl.message(
      'Vui lòng nhập mật khẩu của bạn',
      name: 'validEnterPass',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải dài từ 8 đến 16 kí tự.`
  String get validPass {
    return Intl.message(
      'Mật khẩu phải dài từ 8 đến 16 kí tự.',
      name: 'validPass',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập xác nhận mật khẩu`
  String get validEnterConfirmPass {
    return Intl.message(
      'Vui lòng nhập xác nhận mật khẩu',
      name: 'validEnterConfirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu xác nhận không hợp lệ`
  String get validConfirmPass {
    return Intl.message(
      'Mật khẩu xác nhận không hợp lệ',
      name: 'validConfirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email của bạn`
  String get validEnterEmail {
    return Intl.message(
      'Vui lòng nhập email của bạn',
      name: 'validEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Không đúng định dạng email`
  String get validEmail {
    return Intl.message(
      'Không đúng định dạng email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phoneNumber {
    return Intl.message(
      'Số điện thoại',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số điện thoại`
  String get enterPhoneNumber {
    return Intl.message(
      'Nhập số điện thoại',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get passWord {
    return Intl.message(
      'Mật khẩu',
      name: 'passWord',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mật khẩu`
  String get enterPassword {
    return Intl.message(
      'Nhập mật khẩu',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgotPass {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get signIn {
    return Intl.message(
      'Đăng nhập',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Qúy khách chưa có tài khoản?`
  String get contentNotAccount {
    return Intl.message(
      'Qúy khách chưa có tài khoản?',
      name: 'contentNotAccount',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký ngay!`
  String get nowSignUp {
    return Intl.message(
      'Đăng ký ngay!',
      name: 'nowSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get continueSignUp {
    return Intl.message(
      'Tiếp tục',
      name: 'continueSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng bạn!`
  String get welcomeBack {
    return Intl.message(
      'Chào mừng bạn!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng đăng ký để tiếp tục`
  String get pleaseSignUp {
    return Intl.message(
      'Vui lòng đăng ký để tiếp tục',
      name: 'pleaseSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get signUp {
    return Intl.message(
      'Đăng ký',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get OTP {
    return Intl.message(
      'OTP',
      name: 'OTP',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác nhận `
  String get verificationCode {
    return Intl.message(
      'Mã xác nhận ',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Chúng tôi đã gửi mã xác thức đến số điện thoại của bạn`
  String get weHaveSentTheCode {
    return Intl.message(
      'Chúng tôi đã gửi mã xác thức đến số điện thoại của bạn',
      name: 'weHaveSentTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get submit {
    return Intl.message(
      'Xác nhận',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật thông tin`
  String get updateProfile {
    return Intl.message(
      'Cập nhật thông tin',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Họ`
  String get firstName {
    return Intl.message(
      'Họ',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Tên`
  String get lastName {
    return Intl.message(
      'Tên',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Thành phố`
  String get city {
    return Intl.message(
      'Thành phố',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh`
  String get dateOfBirth {
    return Intl.message(
      'Ngày sinh',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Giới tính`
  String get gender {
    return Intl.message(
      'Giới tính',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Nhập họ của bạn`
  String get enterFirstName {
    return Intl.message(
      'Nhập họ của bạn',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tên của bạn`
  String get enterLastName {
    return Intl.message(
      'Nhập tên của bạn',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Nam`
  String get male {
    return Intl.message(
      'Nam',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Nữ`
  String get female {
    return Intl.message(
      'Nữ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Khác`
  String get other {
    return Intl.message(
      'Khác',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Tạo mật khẩu`
  String get createPass {
    return Intl.message(
      'Tạo mật khẩu',
      name: 'createPass',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa đặt mật khẩu cho tài khoản này, hãy tạo mật khẩu để đăng nhập thuận tiện hơn.`
  String get warningCreatePass {
    return Intl.message(
      'Bạn chưa đặt mật khẩu cho tài khoản này, hãy tạo mật khẩu để đăng nhập thuận tiện hơn.',
      name: 'warningCreatePass',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu`
  String get confirmPass {
    return Intl.message(
      'Xác nhận mật khẩu',
      name: 'confirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu`
  String get enterConfirmPass {
    return Intl.message(
      'Nhập lại mật khẩu',
      name: 'enterConfirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Thêm dịch vụ`
  String get serviceAdd {
    return Intl.message(
      'Thêm dịch vụ',
      name: 'serviceAdd',
      desc: '',
      args: [],
    );
  }

  /// `Tên dịch vụ`
  String get serviceName {
    return Intl.message(
      'Tên dịch vụ',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get amountOfMoney {
    return Intl.message(
      'Số tiền',
      name: 'amountOfMoney',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian bắt đầu`
  String get startTime {
    return Intl.message(
      'Thời gian bắt đầu',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian kết thúc`
  String get endTime {
    return Intl.message(
      'Thời gian kết thúc',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Mô tả dịch vụ`
  String get description {
    return Intl.message(
      'Mô tả dịch vụ',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tên dịch vụ`
  String get enterServiceName {
    return Intl.message(
      'Nhập tên dịch vụ',
      name: 'enterServiceName',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số tiền`
  String get enterAmountOfMoney {
    return Intl.message(
      'Nhập số tiền',
      name: 'enterAmountOfMoney',
      desc: '',
      args: [],
    );
  }

  /// `Nhập giờ`
  String get enterAmountOfTime {
    return Intl.message(
      'Nhập giờ',
      name: 'enterAmountOfTime',
      desc: '',
      args: [],
    );
  }

  /// `Nhập mô tả dịch vụ`
  String get enterServiceDescription {
    return Intl.message(
      'Nhập mô tả dịch vụ',
      name: 'enterServiceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên dịch vụ`
  String get emptyNameError {
    return Intl.message(
      'Vui lòng nhập tên dịch vụ',
      name: 'emptyNameError',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số tiền`
  String get emptyMoneyError {
    return Intl.message(
      'Vui lòng nhập số tiền',
      name: 'emptyMoneyError',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số giờ`
  String get emptyTimeError {
    return Intl.message(
      'Vui lòng nhập số giờ',
      name: 'emptyTimeError',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mô tả dịch vụ`
  String get emptyDescriptionError {
    return Intl.message(
      'Vui lòng nhập mô tả dịch vụ',
      name: 'emptyDescriptionError',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng không nhập số hoặc ký tự đặc biệt`
  String get specialCharsError {
    return Intl.message(
      'Vui lòng không nhập số hoặc ký tự đặc biệt',
      name: 'specialCharsError',
      desc: '',
      args: [],
    );
  }

  /// `Nhập 6 kí tự trở lên`
  String get serviceNameMinLenght {
    return Intl.message(
      'Nhập 6 kí tự trở lên',
      name: 'serviceNameMinLenght',
      desc: '',
      args: [],
    );
  }

  /// `Nhập 10 kí tự trở lên`
  String get descriptionMinLenght {
    return Intl.message(
      'Nhập 10 kí tự trở lên',
      name: 'descriptionMinLenght',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ nhập mệnh giá tiền`
  String get onlyDenominations {
    return Intl.message(
      'Chỉ nhập mệnh giá tiền',
      name: 'onlyDenominations',
      desc: '',
      args: [],
    );
  }

  /// `Chỉ nhập số giờ`
  String get onlyNumberOfTime {
    return Intl.message(
      'Chỉ nhập số giờ',
      name: 'onlyNumberOfTime',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ảnh`
  String get choosePhoto {
    return Intl.message(
      'Chọn ảnh',
      name: 'choosePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách dịch vụ`
  String get serviceList {
    return Intl.message(
      'Danh sách dịch vụ',
      name: 'serviceList',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết dịch vụ`
  String get serviceDetails {
    return Intl.message(
      'Chi tiết dịch vụ',
      name: 'serviceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Tạo dịch vụ đầu tiên của bạn nào`
  String get noServiceYet {
    return Intl.message(
      'Tạo dịch vụ đầu tiên của bạn nào',
      name: 'noServiceYet',
      desc: '',
      args: [],
    );
  }

  /// `Hãy đảm bảo rằng bạn đã bật kết nối mạng`
  String get networkRemind {
    return Intl.message(
      'Hãy đảm bảo rằng bạn đã bật kết nối mạng',
      name: 'networkRemind',
      desc: '',
      args: [],
    );
  }

  /// `Đang làm mới danh sách...`
  String get refreshing {
    return Intl.message(
      'Đang làm mới danh sách...',
      name: 'refreshing',
      desc: '',
      args: [],
    );
  }

  /// `Làm mới danh sách thành công!`
  String get refreshCompleted {
    return Intl.message(
      'Làm mới danh sách thành công!',
      name: 'refreshCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Kéo xuống và thả để làm mới danh sách`
  String get pullToRefresh {
    return Intl.message(
      'Kéo xuống và thả để làm mới danh sách',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Tạo một dịch vụ và thử lại sau`
  String get serviceEmpty {
    return Intl.message(
      'Tạo một dịch vụ và thử lại sau',
      name: 'serviceEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Xoá dịch vụ`
  String get deleteService {
    return Intl.message(
      'Xoá dịch vụ',
      name: 'deleteService',
      desc: '',
      args: [],
    );
  }

  /// `Nếu xóa dịch vụ này, bạn sẽ bị mất dịch vụ khỏi danh sách. Bạn chắc chắn chứ?`
  String get deleteServiceContent {
    return Intl.message(
      'Nếu xóa dịch vụ này, bạn sẽ bị mất dịch vụ khỏi danh sách. Bạn chắc chắn chứ?',
      name: 'deleteServiceContent',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa dịch vụ`
  String get serviceEdit {
    return Intl.message(
      'Chỉnh sửa dịch vụ',
      name: 'serviceEdit',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật dịch vụ thành công!`
  String get successUpdate {
    return Intl.message(
      'Cập nhật dịch vụ thành công!',
      name: 'successUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ phải trên 12 ký tự`
  String get validAddress {
    return Intl.message(
      'Địa chỉ phải trên 12 ký tự',
      name: 'validAddress',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ không được phép trống`
  String get addressIsEmpty {
    return Intl.message(
      'Địa chỉ không được phép trống',
      name: 'addressIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn ngày và giờ`
  String get validHour {
    return Intl.message(
      'Vui lòng chọn ngày và giờ',
      name: 'validHour',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn dịch vụ`
  String get validService {
    return Intl.message(
      'Vui lòng chọn dịch vụ',
      name: 'validService',
      desc: '',
      args: [],
    );
  }

  /// `Dịch vụ`
  String get service {
    return Intl.message(
      'Dịch vụ',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết`
  String get details {
    return Intl.message(
      'Chi tiết',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `HẸN LỊCH`
  String get booking {
    return Intl.message(
      'HẸN LỊCH',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Tên`
  String get name {
    return Intl.message(
      'Tên',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Số giờ`
  String get time {
    return Intl.message(
      'Số giờ',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get price {
    return Intl.message(
      'Số tiền',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get address {
    return Intl.message(
      'Địa chỉ',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Giờ`
  String get hour {
    return Intl.message(
      'Giờ',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Ngày`
  String get date {
    return Intl.message(
      'Ngày',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Thất bại`
  String get failed {
    return Intl.message(
      'Thất bại',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Thành công`
  String get success {
    return Intl.message(
      'Thành công',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản của bạn đã tồn tại. Vui lòng kiểm tra lại`
  String get existsAccount {
    return Intl.message(
      'Tài khoản của bạn đã tồn tại. Vui lòng kiểm tra lại',
      name: 'existsAccount',
      desc: '',
      args: [],
    );
  }

  /// `Hủy bỏ`
  String get cancel {
    return Intl.message(
      'Hủy bỏ',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực không hợp lệ`
  String get validOTP {
    return Intl.message(
      'Mã xác thực không hợp lệ',
      name: 'validOTP',
      desc: '',
      args: [],
    );
  }

  /// `Chọn Thành Phố`
  String get selectCity {
    return Intl.message(
      'Chọn Thành Phố',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Chọn giới tính`
  String get selectGender {
    return Intl.message(
      'Chọn giới tính',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngày sinh`
  String get selectDate {
    return Intl.message(
      'Chọn ngày sinh',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Chưa chọn thành phố`
  String get validCity {
    return Intl.message(
      'Chưa chọn thành phố',
      name: 'validCity',
      desc: '',
      args: [],
    );
  }

  /// `Chưa chọn giới tính`
  String get validGender {
    return Intl.message(
      'Chưa chọn giới tính',
      name: 'validGender',
      desc: '',
      args: [],
    );
  }

  /// `Chưa chọn giới tính`
  String get validDateOfBirth {
    return Intl.message(
      'Chưa chọn giới tính',
      name: 'validDateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản hoặc mật khẩu không chính xác`
  String get validAccount {
    return Intl.message(
      'Tài khoản hoặc mật khẩu không chính xác',
      name: 'validAccount',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng kiểm tra kết nối mạng`
  String get errorNetwork {
    return Intl.message(
      'Vui lòng kiểm tra kết nối mạng',
      name: 'errorNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Tên phải trên 2 kí tự`
  String get validName {
    return Intl.message(
      'Tên phải trên 2 kí tự',
      name: 'validName',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vừa đặt lịch hẹn thành công với`
  String get contentBookingSuccess {
    return Intl.message(
      'Bạn vừa đặt lịch hẹn thành công với',
      name: 'contentBookingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `vào lúc`
  String get at {
    return Intl.message(
      'vào lúc',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng đợi phản hồi.`
  String get contentResponse {
    return Intl.message(
      'Vui lòng đợi phản hồi.',
      name: 'contentResponse',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get emptyVerificationCode {
    return Intl.message(
      '',
      name: 'emptyVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get validVerificationCode {
    return Intl.message(
      '',
      name: 'validVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Dịch vụ`
  String get Service {
    return Intl.message(
      'Dịch vụ',
      name: 'Service',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notification {
    return Intl.message(
      'Thông báo',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Trang cá nhân`
  String get profile {
    return Intl.message(
      'Trang cá nhân',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Thoát ứng dụng?`
  String get exitApp {
    return Intl.message(
      'Thoát ứng dụng?',
      name: 'exitApp',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thoát ứng dụng không?`
  String get exitConfirm {
    return Intl.message(
      'Bạn có muốn thoát ứng dụng không?',
      name: 'exitConfirm',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get lastLine {
    return Intl.message(
      '',
      name: 'lastLine',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vn'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
