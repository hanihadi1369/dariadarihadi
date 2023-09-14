import 'package:flutter/material.dart';

@immutable
abstract class PageBillIndexStatus{}
// index 1 > main bills page
// index 11 > watter bills page
// index 12 > electricity bills page
// index 13 > gas bills page
// index 14 > phone bills page


class PageBillIndexStatus1 extends PageBillIndexStatus{}
class PageBillIndexStatus11 extends PageBillIndexStatus{}
class PageBillIndexStatus12 extends PageBillIndexStatus{}
class PageBillIndexStatus13 extends PageBillIndexStatus{}
class PageBillIndexStatus14 extends PageBillIndexStatus{}
// index 30 >  select bill type to add page
// index 31 > add watter bills page
// index 32 > add electricity bills page
// index 33 > add gas bills page
// index 34 > add phone bills page
class PageBillIndexStatus30 extends PageBillIndexStatus{}
class PageBillIndexStatus31 extends PageBillIndexStatus{}
class PageBillIndexStatus32 extends PageBillIndexStatus{}
class PageBillIndexStatus33 extends PageBillIndexStatus{}
class PageBillIndexStatus34 extends PageBillIndexStatus{}

// index 2  > edit bills page
class PageBillIndexStatus2 extends PageBillIndexStatus{}