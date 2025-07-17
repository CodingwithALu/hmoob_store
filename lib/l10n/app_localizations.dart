import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// Default admin email
  ///
  /// In en, this message translates to:
  /// **'support@codingwitht.com'**
  String get adminEmail;

  /// Button to change profile picture
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// Section heading for profile information
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// Section heading for personal information
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Label for name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for user ID field
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Label for gender field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Label for date of birth field
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Button to close account
  ///
  /// In en, this message translates to:
  /// **'Close Account'**
  String get closeAccount;

  /// Subtitle for address settings
  ///
  /// In en, this message translates to:
  /// **'Set shopping delivery address'**
  String get myAddressSub;

  /// Subtitle for cart settings
  ///
  /// In en, this message translates to:
  /// **'Add, remove products and move to checkout'**
  String get myCartSub;

  /// Subtitle for orders settings
  ///
  /// In en, this message translates to:
  /// **'In-progress and Completed Orders'**
  String get myOrdersSub;

  /// Subtitle for bank account settings
  ///
  /// In en, this message translates to:
  /// **'Withdraw balance to registered bank account'**
  String get bankAccountSub;

  /// Subtitle for coupons settings
  ///
  /// In en, this message translates to:
  /// **'List off all the discounted coupons'**
  String get myCouponsSub;

  /// Subtitle for notifications settings
  ///
  /// In en, this message translates to:
  /// **'Set any kind of notifications message'**
  String get notificationsSub;

  /// Subtitle for account privacy settings
  ///
  /// In en, this message translates to:
  /// **'Manage data usage and connected accounts'**
  String get accountPrivacySub;

  /// Subtitle for load data settings
  ///
  /// In en, this message translates to:
  /// **'Upload Data to your Cloud Firebase'**
  String get loadDataSub;

  /// Subtitle for geolocation settings
  ///
  /// In en, this message translates to:
  /// **'Set recommendation based on location'**
  String get geolocationSub;

  /// Subtitle for safe mode settings
  ///
  /// In en, this message translates to:
  /// **'Search result is safe for all ages'**
  String get safeModeSub;

  /// Subtitle for HD image quality settings
  ///
  /// In en, this message translates to:
  /// **'Set image quality to be seen'**
  String get hdImageQualitySub;

  /// Title for account section in settings
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Title for account settings section
  ///
  /// In en, this message translates to:
  /// **'Account Setting'**
  String get accountSetting;

  /// Title for address settings
  ///
  /// In en, this message translates to:
  /// **'My Address'**
  String get myAddress;

  /// Title for cart settings
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// Title for orders settings
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// Title for bank account settings
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get bankAccount;

  /// Title for coupons settings
  ///
  /// In en, this message translates to:
  /// **'My Coupons'**
  String get myCoupons;

  /// Title for notifications settings
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Title for account privacy settings
  ///
  /// In en, this message translates to:
  /// **'Account Privacy'**
  String get accountPrivacy;

  /// Title for app settings section
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Title for load data settings
  ///
  /// In en, this message translates to:
  /// **'Load Data'**
  String get loadData;

  /// Title for geolocation settings
  ///
  /// In en, this message translates to:
  /// **'Geolocation'**
  String get geolocation;

  /// Title for safe mode settings
  ///
  /// In en, this message translates to:
  /// **'Safe Mode'**
  String get safeMode;

  /// Title for HD image quality settings
  ///
  /// In en, this message translates to:
  /// **'HD Image Quality'**
  String get hdImageQuality;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Default admin password
  ///
  /// In en, this message translates to:
  /// **'Admin@123'**
  String get adminPassword;

  /// Message when wishlist is empty
  ///
  /// In en, this message translates to:
  /// **'Whoops! Wishlist is Empty...'**
  String get wishlistEmpty;

  /// Action text to add items to wishlist when empty
  ///
  /// In en, this message translates to:
  /// **'Let\'s add some'**
  String get wishlistAddSome;

  /// Storage path for banners
  ///
  /// In en, this message translates to:
  /// **'/Banners'**
  String get bannersStoragePath;

  /// Storage path for brands
  ///
  /// In en, this message translates to:
  /// **'/Brands'**
  String get brandsStoragePath;

  /// Storage path for categories
  ///
  /// In en, this message translates to:
  /// **'/Categories'**
  String get categoriesStoragePath;

  /// Storage path for products
  ///
  /// In en, this message translates to:
  /// **'/Products'**
  String get productsStoragePath;

  /// Storage path for users
  ///
  /// In en, this message translates to:
  /// **'/Users'**
  String get usersStoragePath;

  /// The word 'and'
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'T Store'**
  String get appName;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get tContinue;

  /// Onboarding step 1 title
  ///
  /// In en, this message translates to:
  /// **'Choose your product'**
  String get onBoardingTitle1;

  /// Onboarding step 2 title
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get onBoardingTitle2;

  /// Onboarding step 3 title
  ///
  /// In en, this message translates to:
  /// **'Deliver at your door step'**
  String get onBoardingTitle3;

  /// Onboarding step 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Welcome to a World of Limitless Choices - Your Perfect Product Awaits!'**
  String get onBoardingSubTitle1;

  /// Onboarding step 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!'**
  String get onBoardingSubTitle2;

  /// Onboarding step 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!'**
  String get onBoardingSubTitle3;

  /// First name field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last name field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Email field
  ///
  /// In en, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// Password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// New password field
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNo;

  /// Remember me checkbox
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword;

  /// Sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Create account button
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Or sign in with text
  ///
  /// In en, this message translates to:
  /// **'or sign in with'**
  String get orSignInWith;

  /// Or sign up with text
  ///
  /// In en, this message translates to:
  /// **'or sign up with'**
  String get orSignUpWith;

  /// I agree to text
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// Privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of use link
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// Verification code label
  ///
  /// In en, this message translates to:
  /// **'verificationCode'**
  String get verificationCode;

  /// Resend email button
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// Resend email in text
  ///
  /// In en, this message translates to:
  /// **'Resend email in'**
  String get resendEmailIn;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get loginTitle;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Discover Limitless Choices and Unmatched Convenience.'**
  String get loginSubTitle;

  /// Signup screen title
  ///
  /// In en, this message translates to:
  /// **'Let’s create your account'**
  String get signupTitle;

  /// Forgot password screen title
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgetPasswordTitle;

  /// Forgot password screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.'**
  String get forgetPasswordSubTitle;

  /// Password reset email sent title
  ///
  /// In en, this message translates to:
  /// **'Password Reset Email Sent'**
  String get changeYourPasswordTitle;

  /// Password reset email sent subtitle
  ///
  /// In en, this message translates to:
  /// **'Your Account Security is Our Priority! We\'ve Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.'**
  String get changeYourPasswordSubTitle;

  /// Confirm email title
  ///
  /// In en, this message translates to:
  /// **'Verify your email address!'**
  String get confirmEmail;

  /// Confirm email subtitle
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.'**
  String get confirmEmailSubTitle;

  /// Email not received message
  ///
  /// In en, this message translates to:
  /// **'Didn’t get the email? Check your junk/spam or resend it.'**
  String get emailNotReceivedMessage;

  /// Account created title
  ///
  /// In en, this message translates to:
  /// **'Your account successfully created!'**
  String get yourAccountCreatedTitle;

  /// Account created subtitle
  ///
  /// In en, this message translates to:
  /// **'Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!'**
  String get yourAccountCreatedSubTitle;

  /// Home app bar title
  ///
  /// In en, this message translates to:
  /// **'Good day for shopping'**
  String get homeAppbarTitle;

  /// Home app bar subtitle
  ///
  /// In en, this message translates to:
  /// **'Taimoor Sikander'**
  String get homeAppbarSubTitle;

  /// Search bar placeholder text on home screen
  ///
  /// In en, this message translates to:
  /// **'Search in Store'**
  String get searchInStore;

  /// Section heading for popular categories
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategories;

  /// Section heading for popular products
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get popularProducts;

  /// Title for all popular products screen
  ///
  /// In en, this message translates to:
  /// **'Popular Product'**
  String get popularProduct;

  /// Message when no data is found
  ///
  /// In en, this message translates to:
  /// **'No data found!'**
  String get noDataFound;

  /// Message no vew all
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// Store screen title
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// Section heading for featured brands
  ///
  /// In en, this message translates to:
  /// **'Featured Brands'**
  String get featuredBrands;

  /// Label for Home tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for Wishlist tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// Label for Profile tab in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Section heading for recommended products in category tab
  ///
  /// In en, this message translates to:
  /// **'You might like'**
  String get youMightLike;

  /// Dialog title for delete account warning
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// Dialog message for delete account warning
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to delete your account permanently? This is not reversible and all of your data will be removed permanently'**
  String get deleteAccountMessage;

  /// Confirm button for delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAccountConfirm;

  /// Cancel button for delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteAccountCancel;

  /// Loader message for processing actions
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// Title for error snackbars
  ///
  /// In en, this message translates to:
  /// **'Oh Snap!'**
  String get ohSnap;

  /// Title for data not saved snackbar
  ///
  /// In en, this message translates to:
  /// **'Data not saved'**
  String get dataNotSaved;

  /// Message for data not saved snackbar
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while saving your information. You can re-save your data in your Profile'**
  String get dataNotSavedMessage;

  /// Title for success snackbar
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// Message for successful profile image update
  ///
  /// In en, this message translates to:
  /// **'Your Profile Image has been updated!'**
  String get profileImageUpdated;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get somethingWentWrong;

  /// Title for Change Name screen
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeNameTitle;

  /// Description under Change Name title
  ///
  /// In en, this message translates to:
  /// **'User real name for easy verifications. This name will appear on several pages'**
  String get changeNameDescription;

  /// Save button text on Change Name screen
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Title for Add New Address screen
  ///
  /// In en, this message translates to:
  /// **'Add new Address'**
  String get addNewAddressTitle;

  /// Label for name field in address form
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get addressNameLabel;

  /// Label for phone number field in address form
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get addressPhoneLabel;

  /// Label for street field in address form
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get addressStreetLabel;

  /// Label for postal code field in address form
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get addressPostalCodeLabel;

  /// Label for city field in address form
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get addressCityLabel;

  /// Label for state field in address form
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get addressStateLabel;

  /// Label for country field in address form
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get addressCountryLabel;

  /// Title for Re-Authentication screen
  ///
  /// In en, this message translates to:
  /// **'Re-Authenticate User'**
  String get reAuthTitle;

  /// Button text for verify action on Re-Authentication screen
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// Title for user addresses screen
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addressesTitle;

  /// Checkout button text on product detail screen
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutButton;

  /// Section heading for product variation attributes
  ///
  /// In en, this message translates to:
  /// **'Variation'**
  String get variationSection;

  /// Label for price in product attributes
  ///
  /// In en, this message translates to:
  /// **'Price : '**
  String get priceLabel;

  /// Label for stock in product attributes
  ///
  /// In en, this message translates to:
  /// **'Stock : '**
  String get stockLabel;

  /// Section heading for product attributes
  ///
  /// In en, this message translates to:
  /// **'Attributes'**
  String get attributesSection;

  /// Label for attribute value in product attributes
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get attributeValueLabel;

  /// Label for unavailable attribute value in product attributes
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get attributeUnavailable;

  /// Label for variation description in product attributes
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get variationDescription;

  /// Section heading for product description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionSection;

  /// Section heading for product reviews
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewSection;

  /// Show more text for ReadMore widget
  ///
  /// In en, this message translates to:
  /// **' Show more'**
  String get showMore;

  /// Show less text for ReadMore widget
  ///
  /// In en, this message translates to:
  /// **' Less'**
  String get showLess;

  /// Button text for adding product to cart
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCartButton;

  /// Label for product quantity in add to cart widget
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
