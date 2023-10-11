import 'package:shakosh/new/Data/Models/AreasModel.dart';
import 'package:shakosh/new/Data/Models/BranchesModel.dart';
import 'package:shakosh/new/Data/Models/CitiesModel.dart';
import 'package:shakosh/new/Data/Models/CountriesModel.dart';
import 'package:shakosh/new/Data/Models/CouponsModel.dart';
import 'package:shakosh/new/Data/Models/PaymentsModel.dart';
import 'package:shakosh/new/Data/Models/TaxesModel.dart';

class DependantsModel {
  List<CountriesModel>? countries;
  List<CitiesModel>? cities;
  List<AreasModel>? areas;
  List<BranchesModel>? branches;
  List<PaymentsModel>? payments;
  List<CouponsModel>? coupons;
  List<TaxesModel>? taxes;

  DependantsModel(
      {this.countries,
      this.cities,
      this.areas,
      this.branches,
      this.payments,
      this.coupons,
      this.taxes});

  DependantsModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <CountriesModel>[];
      json['countries'].forEach((v) {
        countries!.add(CountriesModel.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <CitiesModel>[];
      json['cities'].forEach((v) {
        cities!.add(CitiesModel.fromJson(v));
      });
    }
    if (json['areas'] != null) {
      areas = <AreasModel>[];
      json['areas'].forEach((v) {
        areas!.add(AreasModel.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <BranchesModel>[];
      json['branches'].forEach((v) {
        branches!.add(BranchesModel.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = <PaymentsModel>[];
      json['payments'].forEach((v) {
        payments!.add(PaymentsModel.fromJson(v));
      });
    }
    if (json['coupons'] != null) {
      coupons = <CouponsModel>[];
      json['coupons'].forEach((v) {
        coupons!.add(CouponsModel.fromJson(v));
      });
    }
    if (json['taxes'] != null) {
      taxes = <TaxesModel>[];
      json['taxes'].forEach((v) {
        taxes!.add(TaxesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
