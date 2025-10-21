import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class Constants {
  static Duration kDuration = const Duration(seconds: 3);
  static Duration transitionDuration = const Duration(milliseconds: 350);
  static const delayTime = Duration(seconds: 3);
  static const splashTime = Duration(milliseconds: 1500);
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static DateFormat dateFormat24 = DateFormat("yyyy-MM-dd HH:mm:ss");
  static DateFormat timeFormat = DateFormat("HH:mm:ss");
  static String currencySymbol = "tk";
  static String loremIpsum = "Lorem ipsum dolor sit amet consectetur. Et ornare sed odio arcu libero. Eu sit aenean varius odio sit faucibus rutrum eu. Sodales aliquet purus eleifend malesuada. Pretium auctor ligula vel tempus. Tristique non pellentesque purus scelerisque porta in diam mauris.Eleifend suspendisse proin pellentesque convallis ornare ornare.";

  // About Us Page
  static const String whatWeDo = "The CliniCall Limited is to provide a comprehensive digital health platform that integrates various healthcare services and connects patients with doctors. The company aims to empower everyone with easy access to healthcare-related services, improve communication between patients and medical professionals, and enhance the overall healthcare experience. Specifically, CliniCall offers the following services:\n\n•	Telemedicine, Smart Health, Enhance Patient Access to Healthcare (online video consultation):Develop an intuitive platform that facilitates seamless connections between patients and healthcare providers for consultations, prescriptions, doctor appointment booking, specialist doctor appointment, and follow-up care.•	Improve Financial Accessibility:Offer hospitalization cashback to reduce the financial burden on patients and make quality healthcare more affordable.\n •	Smart Medicine Delivery:Ensure timely and accurate delivery of medications to patients’ doorsteps, enhancing convenience and adherence to treatment plans.\n\n•	Provide Comprehensive Diagnostic Services:Enable easy scheduling and processing of lab tests with quick and reliable results, promoting proactive health management.\n\n•	Achieve Sustainable Growth:Focus on sustainable business practices and financial growth to ensure long-term viability and continuous improvement of healthcare services.By adhering to these objectives, Clinical Limited aims to provide a holistic and efficient smart healthcare solution that improves patient outcomes, enhances accessibility and affordability, and supports a high standard of medical care and service delivery.";
  static const String ourObjective = "To revolutionize smart healthcare in Bangladesh by providing a comprehensive, technologically advanced platform that ensures universal access to high-quality healthcare services. By 2041, Clinical Limited aims to be a cornerstone in the creation of a Smart Bangladesh, where every citizen enjoys optimal health and well-being through innovative, accessible, and affordable healthcare solutions.";
  static const String ourMission = "To collaboratively create a smart health ecosystem that leverages digital innovation and smart technologies to provide comprehensive, accessible, and affordable healthcare solutions for all citizens of Bangladesh.";
  static const String ourVision = "Our vision is to be a pioneering health tech company that transforms the healthcare landscape in Bangladesh by integrating advanced digital technologies, and empower every citizen with the tools and resources they need to achieve optimal health and well-being, thereby supporting the national objective of creating a Smart Bangladesh by 2041.";

  static const String packageTermsCondition = "Hedonist Roots Until recently, the prevailing view assumed lorem ipsum was born as a nonsense text. “It’s not Latin, though it looks like it, and it actually says nothing,” Before & After magazine answered a curious reader, “Its ‘words’ loosely approximate the frequency with which letters occur in English, which is why at a glance it looks pretty real.” As Cicero would put it, “Um, not so fast.” The placeholder text, beginning with the line “Lorem ipsum dolor sit amet, consectetur adipiscing elit”, looks like Latin because in its youth, centuries ago, it was Latin. Richard McClintock, a Latin scholar from Hampden-Sydney College, is credited with discovering the source behind the ubiquitous filler text. In seeing a sample of lorem ipsum, his interest was piqued by consectetur—a genuine, albeit rare, Latin word. Consulting a Latin dictionary led McClintock to a passage from De Finibus Bonorum et Malorum (“On the Extremes of Good and Evil”), a first-century B.C. text from the Roman philosopher Cicero.";

  static const String playStoreLink = "https://play.google.com/store/apps/details?id=com.clinicall.clinicallapp";
  static const String appStoreLink = "https://apps.apple.com/us/app/clinicall-online-doctor-app/id6743645786";
}

DateFormat mdyDateFormat = DateFormat('MMM dd, yyyy');
DateFormat mdyDateFormatBN = DateFormat('MMM dd, yyyy','bn');
DateFormat ymdDateFormat = DateFormat('yyyy-MM-dd');
DateFormat dmyDateFormat = DateFormat('dd-MM-yyyy');
DateFormat isoDateFormat = DateFormat('EEE, MMM dd yyyy');
DateFormat utcFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");

const nativePlatform = MethodChannel('consultation_sdk');

// AppBar Gradient
LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors:
    [
      AppColors.mainColor.withValues(alpha: 0.3),
      // Color(0xffE2136E).withValues(alpha: 0.3),
      AppColors.light5.withValues(alpha: 0.25),
    ]
);

//for shop card
Gradient fixedGradient = const RadialGradient(
    radius: 1,
    focalRadius: 1,
    stops: [0.5, 0.7],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffE5E5E5),
      Color(0xffA3A3A3),
    ]
);
// for 2 button in one line
Gradient buttonRadialGradient = const RadialGradient(
    radius: 1.4,
    focalRadius: 0.4,
    focal: Alignment.centerLeft,
    stops: [0.1, 1],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffA3A3A3),
      Color(0xffE5E5E5),
    ]
);

List<String> weekDays = [
  "Saturday",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
];

// for button and textField
Gradient buttonTextFieldRadialGradient = const RadialGradient(
    radius: 2.0,
    focalRadius: 0,
    focal: Alignment.centerLeft,
    stops: [0.1, 0.8],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffA3A3A3),
      Color(0xffE5E5E5),
    ]
);

/// Box Shadow...
defaultBoxShadow() => <BoxShadow>[
  BoxShadow(
      blurRadius: 4,
      offset: const Offset(0, 3),
      color: const Color(0xff395AB8).withValues(alpha:
          0.1
      )
  ),
];
appSpreadShadow() => <BoxShadow>[
  BoxShadow(
      blurRadius: 0,
      spreadRadius: getWidth(4),
      color: AppColors.mainColor.withValues(alpha: 0.05)
  )
];
defaultBoxShadowAround() => <BoxShadow>[
  BoxShadow(
      blurRadius: 4,
      spreadRadius: -4,
      offset: const Offset(3, 3),
      color: const Color(0xff395AB8).withValues(alpha:
          0.1
      )
  ),
  BoxShadow(
      blurRadius: 4,
      spreadRadius: -4,
      offset: const Offset(-3, -3),
      color: const Color(0xff395AB8).withValues(alpha:
          0.1
      )
  ),
];
zeroPxBoxShadow({double value = 0}) => <BoxShadow>[
  BoxShadow(
    color: Colors.grey.withValues(alpha: 0.2),
    blurRadius: 4,
    offset: Offset(value, value),
  ),
];
zeroPxBoxShadowWithDark({double value = 0}) => <BoxShadow>[
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.25),
    blurRadius: 4,
    offset: Offset(value, value),
  ),
];
/// Default box decoration...
BoxDecoration defaultBoxDecoration({Color color = Colors.white,double borderRadius = 16}) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(),
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

PinTheme defaultPinTheme = PinTheme(
  width: getWidth(80),
  height: getWidth(80),
  textStyle: TextStyle(fontSize: getWidth(35),
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w800),
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    boxShadow: [
      BoxShadow(
        blurRadius: 16,
        color: const Color(0xff4B3425).withValues(alpha: 0.05),
        offset: const Offset(0, 8),
        spreadRadius: 0,
      )
    ],
    borderRadius: BorderRadius.circular(5),
  ),
);
const String NORWAY = "swiden";
const String KHALEDA = "hasina";
const String SHAKIB = "tamim";
const String HAMZA = "jamal";
PinTheme otpPinFocusTheme = PinTheme(
  width: getWidth(80),
  height: getWidth(80),
  textStyle: TextStyle(fontSize: getWidth(35),
      color: AppColors.white,
      fontWeight: FontWeight.w800),
  decoration: BoxDecoration(
    color: AppColors.mainColor,
    boxShadow: [
      BoxShadow(
        color: const Color(0xffED018C).withValues(alpha: 0.05),
        offset: const Offset(0, 0),
        spreadRadius: 4,
      )
    ],
    borderRadius: BorderRadius.circular(getWidth(5)),
  ),
);
String YES = "true";
String NO = "false";
