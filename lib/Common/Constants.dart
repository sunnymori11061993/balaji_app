import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//const String SOAP_API_URL = "http://pmc.studyfield.com/Service.asmx/";

//const String API_URL = "https://webnappmaker.in/Balaji/Admin/Ajax/";
//const String API_URL = "http://balajinew.idnmserver.com/Admin/Ajax/";
const String API_URL = "http://balajiwholesalebazaar.com/AdminSide/Admin/Ajax";
//const String Image_URL = "https://webnappmaker.in/Balaji/resources/images/";
//const String Image_URL = "http://balaji.idnmserver.com/resources/images/";
const String Image_URL =
    "http://balajiwholesalebazaar.com/AdminSide/resources/images/";

const Inr_Rupee = "₹";
const Color appcolor = Color.fromRGBO(0, 171, 199, 1);
const Color secondaryColor = Color.fromRGBO(85, 96, 128, 1);

//const String whatsAppLink = "https://wa.me/#mobile?text=#msg"; //mobile no with country code

Map<int, Color> appprimarycolors = {
  50: Color.fromRGBO(103, 28, 92, .1),
  100: Color.fromRGBO(103, 28, 92, .2),
  200: Color.fromRGBO(103, 28, 92, .3),
  300: Color.fromRGBO(103, 28, 92, .4),
  400: Color.fromRGBO(103, 28, 92, .5),
  500: Color.fromRGBO(103, 28, 92, .6),
  600: Color.fromRGBO(103, 28, 92, .7),
  700: Color.fromRGBO(103, 28, 92, .8),
  800: Color.fromRGBO(103, 28, 92, .9),
  900: Color.fromRGBO(103, 28, 92, 1)
};

MaterialColor appPrimaryMaterialColor =
    MaterialColor(0xFF671C5C, appprimarycolors);

class Session {
  static const String CustomerId = "CustomerId";
  static const String ManufacturerId = "ManufacturerId";
  static const String CustomerName = "CustomerName";
  static const String addressId = "addressId";
  static const String type = "type";
  static const String CustomerCompanyName = "CustomerCompanyName";
  static const String CustomerEmailId = "CustomerEmailId";
  static const String CustomerPhoneNo = "CustomerPhoneNo";
  static const String CustomerCDT = "CustomerCDT";
  static const String CustomerStatus = "CustomerStatus";
  static const String ManufacturerName = "ManufacturerName";
  static const String ManufacturerPhoneNo = "ManufacturerPhoneNo";
  static const String ManufacturerAddress = "ManufacturerAddress";
  static const String ManufacturerCompanyName = "ManufacturerCompanyName";
  static const String ManufacturerEmailId = "ManufacturerEmailId";
  static const String CustomerImage = "CustomerImage";
  static const String ManuCustomerImage = "ManuCustomerImage";
  static const String langauge = "language";
  static const String v = "__v";
  static const String CustomerGSTNo = "CustomerGSTNo";
  static const String ManufacturerGSTNo = "ManufacturerGSTNo";
}

class showSession {
  static const String showCaseHome = "showCaseHome";
  static const String showCaseWislist = "showCaseWislist";
  static const String showCaseUserProfile = "showCaseUserProfile";
  static const String showCaseSetting = "showCaseSetting";
  static const String showCaseNoti = "showCaseNoti";
  static const String showCaseCart = "showCaseCart";
  static const String showCaseSubCat = "showCaseSubCat";
  static const String showCaseProductDetail = "showCaseProductDetail";
  static const String showCaseEditProfile = "showCaseEditProfile";
  static const String showCaseAddress = "showCaseAddress";
  static const String showCaseHistory = "showCaseHistory";
  static const String showCasefaq = "showCasefaq";
  static const String showCaseABoutUs = "showCaseABoutUs";
}
