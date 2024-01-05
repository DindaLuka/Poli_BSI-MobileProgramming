class Pegawai {
  int? idPegawai;
  String namaPegawai;
  String nip;
  String tanggalLahir;
  String nomorTelepon;
  String email;
  String password;

  Pegawai({
    required this.idPegawai,
    required this.namaPegawai,
    required this.nip,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
    required this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        idPegawai: json["idPegawai"],
        namaPegawai: json["namaPegawai"],
        nip: json["nip"],
        tanggalLahir: json["tanggalLahir"],
        nomorTelepon: json["nomorTelepon"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "idPegawai": idPegawai,
        "namaPegawai": namaPegawai,
        "nip": nip,
        "tanggalLahir": tanggalLahir,
        "nomorTelepon": nomorTelepon,
        "email": email,
        "password": password,
      };
}