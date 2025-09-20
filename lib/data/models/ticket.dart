class Ticket {
  int? id;
  int? fkService;
  int? fkTableDineIn;
  String? tableDineInName;
  int? fkCustomer;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  String? customerPostcode;
  String? customerCountry;
  String? barcode;
  int? itemSubtotal;
  int? discountTotal;
  int? discountBeforeTaxTotal;
  int? serviceCharge;
  int? subtotal;
  int? taxIncluded;
  int? tax;
  int? total;
  int? tip;
  int? rounding;
  int? grandTotal;
  int? payment;
  int? surcharge;
  String? eta;
  String? note;
  String? information;
  String? status;
  String? created;
  String? updated;
  String? paid;

  Ticket(
      {this.id,
      this.fkService,
      this.fkTableDineIn,
      this.tableDineInName,
      this.fkCustomer,
      this.customerName,
      this.customerMobile,
      this.customerAddress,
      this.customerCity,
      this.customerState,
      this.customerPostcode,
      this.customerCountry,
      this.barcode,
      this.itemSubtotal,
      this.discountTotal,
      this.discountBeforeTaxTotal,
      this.serviceCharge,
      this.subtotal,
      this.taxIncluded,
      this.tax,
      this.total,
      this.tip,
      this.rounding,
      this.grandTotal,
      this.payment,
      this.surcharge,
      this.eta,
      this.note,
      this.information,
      this.status,
      this.created,
      this.updated,
      this.paid});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fkService = json['fkService'];
    fkTableDineIn = json['fkTableDineIn'];
    tableDineInName = json['tableDineInName'];
    fkCustomer = json['fkCustomer'];
    customerName = json['customerName'];
    customerMobile = json['customerMobile'];
    customerAddress = json['customerAddress'];
    customerCity = json['customerCity'];
    customerState = json['customerState'];
    customerPostcode = json['customerPostcode'];
    customerCountry = json['customerCountry'];
    barcode = json['barcode'];
    itemSubtotal = json['itemSubtotal'];
    discountTotal = json['discountTotal'];
    discountBeforeTaxTotal = json['discountBeforeTaxTotal'];
    serviceCharge = json['serviceCharge'];
    subtotal = json['subtotal'];
    taxIncluded = json['taxIncluded'];
    tax = json['tax'];
    total = json['total'];
    tip = json['tip'];
    rounding = json['rounding'];
    grandTotal = json['grandTotal'];
    payment = json['payment'];
    surcharge = json['surcharge'];
    eta = json['eta'];
    note = json['note'];
    information = json['information'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fkService'] = fkService;
    data['fkTableDineIn'] = fkTableDineIn;
    data['tableDineInName'] = tableDineInName;
    data['fkCustomer'] = fkCustomer;
    data['customerName'] = customerName;
    data['customerMobile'] = customerMobile;
    data['customerAddress'] = customerAddress;
    data['customerCity'] = customerCity;
    data['customerState'] = customerState;
    data['customerPostcode'] = customerPostcode;
    data['customerCountry'] = customerCountry;
    data['barcode'] = barcode;
    data['itemSubtotal'] = itemSubtotal;
    data['discountTotal'] = discountTotal;
    data['discountBeforeTaxTotal'] = discountBeforeTaxTotal;
    data['serviceCharge'] = serviceCharge;
    data['subtotal'] = subtotal;
    data['taxIncluded'] = taxIncluded;
    data['tax'] = tax;
    data['total'] = total;
    data['tip'] = tip;
    data['rounding'] = rounding;
    data['grandTotal'] = grandTotal;
    data['payment'] = payment;
    data['surcharge'] = surcharge;
    data['eta'] = eta;
    data['note'] = note;
    data['information'] = information;
    data['status'] = status;
    data['created'] = created;
    data['updated'] = updated;
    data['paid'] = paid;
    return data;
  }
}
