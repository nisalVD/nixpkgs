{ lib, stdenv, fetchurl, libpcap, tcpdump, Carbon, CoreServices }:

stdenv.mkDerivation rec {
  pname = "tcpreplay";
  version = "4.4.4";

  src = fetchurl {
    url = "https://github.com/appneta/tcpreplay/releases/download/v${version}/tcpreplay-${version}.tar.gz";
    sha256 = "sha256-RPGPttNHDsr3elG5AaEZ2uFtpb5NQUD/uyeF43rW1L8=";
  };

  buildInputs = [ libpcap ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      Carbon CoreServices
    ];


  configureFlags = [
    "--disable-local-libopts"
    "--disable-libopts-install"
    "--enable-dynamic-link"
    "--enable-shared"
    "--enable-tcpreplay-edit"
    "--with-libpcap=${libpcap}"
    "--with-tcpdump=${tcpdump}/bin/tcpdump"
  ];

  meta = with lib; {
    description = "A suite of utilities for editing and replaying network traffic";
    homepage = "https://tcpreplay.appneta.com/";
    license = with licenses; [ bsdOriginalUC gpl3Only ];
    maintainers = with maintainers; [ eleanor ];
    platforms = platforms.unix;
  };
}
