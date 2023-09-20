import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



// index 1 > main wallet page
// index 2 > increase main page -- 21 increase sub1 --22 increase sub2
// index 3 > decrease main page
// index 4 > transfer main page -- 41 transfer sub1



@immutable
abstract class PageWalletIndexStatus extends Equatable{}


class PageWalletIndexStatus1 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}

class PageWalletIndexStatus2 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}
class PageWalletIndexStatus21 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}
class PageWalletIndexStatus22 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}

class PageWalletIndexStatus3 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}

class PageWalletIndexStatus4 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}
class PageWalletIndexStatus41 extends PageWalletIndexStatus{
  @override
  List<Object?> get props => [];
}

