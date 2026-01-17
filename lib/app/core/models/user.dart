// /// Doctor User Model
// class DoctorUser {
//   /// id : 1
//   /// name : "Dr. John Doe"
//   /// email : "dr.john@hospital.com"
//   /// phone : "+8801712345678"
//   /// specialization : "Cardiology"
//   /// license_number : "BMDC-123456"
//   /// chamber_address : "123 Medical Street, Dhaka"
//   /// consultation_fee : 500.0
//   /// available_days : ["Mon", "Wed", "Fri"]
//   /// degree : "MBBS, FCPS"
//   /// experience_years : 10
//   /// rating : 4.8
//   /// profile_image : "https://example.com/profile.jpg"
//   /// email_verified : 1
//   /// status : 1
//   /// created_at : "2024-01-01T10:00:00.000Z"
//   /// updated_at : "2024-01-01T10:00:00.000Z"

//   DoctorUser({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.specialization,
//     this.licenseNumber,
//     this.chamberAddress,
//     this.consultationFee,
//     this.availableDays,
//     this.degree,
//     this.experienceYears,
//     this.rating,
//     this.profileImage,
//     this.emailVerified,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   DoctorUser.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     specialization = json['specialization'];
//     licenseNumber = json['license_number'];
//     chamberAddress = json['chamber_address'];
//     consultationFee = json['consultation_fee']?.toDouble();
//     availableDays = json['available_days'] != null 
//         ? List<String>.from(json['available_days']) 
//         : [];
//     degree = json['degree'];
//     experienceYears = json['experience_years'];
//     rating = json['rating']?.toDouble();
//     profileImage = json['profile_image'];
//     emailVerified = json['email_verified'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? specialization;          // নতুন field
//   String? licenseNumber;           // নতুন field (BMDC number)
//   String? chamberAddress;          // নতুন field
//   double? consultationFee;         // নতুন field
//   List<String>? availableDays;     // নতুন field
//   String? degree;                  // নতুন field
//   int? experienceYears;            // নতুন field
//   double? rating;                  // নতুন field
//   String? profileImage;
//   int? emailVerified;
//   int? status;
//   String? createdAt;
//   String? updatedAt;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['email'] = email;
//     map['phone'] = phone;
//     map['specialization'] = specialization;
//     map['license_number'] = licenseNumber;
//     map['chamber_address'] = chamberAddress;
//     map['consultation_fee'] = consultationFee;
//     map['available_days'] = availableDays;
//     map['degree'] = degree;
//     map['experience_years'] = experienceYears;
//     map['rating'] = rating;
//     map['profile_image'] = profileImage;
//     map['email_verified'] = emailVerified;
//     map['status'] = status;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     return map;
//   }
// }