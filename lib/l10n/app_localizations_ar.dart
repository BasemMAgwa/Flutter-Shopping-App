// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مشروعي الأول';

  @override
  String get signUpTitle => 'إنشاء حساب';

  @override
  String get shoppingPageTitle => 'مشروعي الأول';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أحمد محمد';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get showPasswordTooltip => 'إظهار كلمة المرور';

  @override
  String get hidePasswordTooltip => 'إخفاء كلمة المرور';

  @override
  String get createAccount => 'إنشاء الحساب';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get nameCapitalError => 'يجب أن يبدأ الاسم بحرف إنجليزي كبير';

  @override
  String get emailError => 'أدخل بريدًا إلكترونيًا يحتوي على @';

  @override
  String get passwordLengthError => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get passwordMismatchError => 'كلمتا المرور غير متطابقتين';

  @override
  String get accountCreated => 'تم إنشاء الحساب بنجاح';

  @override
  String get continueButton => 'متابعة';

  @override
  String get ourProducts => 'منتجاتنا';

  @override
  String get hotOffers => 'عروض مميزة';

  @override
  String get imagesDisplayed => 'تم عرض الصورتين';

  @override
  String get addToCartTooltip => 'أضف إلى السلة';

  @override
  String get removeFromCartTooltip => 'إزالة من السلة';

  @override
  String get itemAddedToCart => 'تمت إضافة المنتج إلى السلة';

  @override
  String get itemRemovedFromCart => 'تمت إزالة المنتج من السلة';

  @override
  String get cartTooltip => 'سلة التسوق';

  @override
  String get changeLanguageTooltip => 'تغيير اللغة';

  @override
  String get productHeadphones => 'سماعات لاسلكية';

  @override
  String get productShoes => 'حذاء رياضي';

  @override
  String get productWatch => 'ساعة ذكية';

  @override
  String get productBackpack => 'حقيبة سفر';

  @override
  String get productCamera => 'كاميرا رقمية';

  @override
  String productPrice(String price) {
    return '$price دولار';
  }

  @override
  String hotOfferName(String product) {
    return 'عرض خاص: $product';
  }

  @override
  String get hotOfferDescription => 'سعر لفترة محدودة على هذا المنتج المميز.';

  @override
  String get imageLoadError => 'الصورة غير متاحة';
}
