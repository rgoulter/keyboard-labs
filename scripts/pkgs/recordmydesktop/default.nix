{ stdenv
# , buildPackages
, fetchFromGitHub
, autoconf
, automake
, zlib
, xorg
, libogg
, libvorbis
, libtheora
, jack2
, popt
}:

let
  pname = "recordmydesktop";
  version = "0.4.0";
  recordmydesktop-src = fetchFromGitHub {
    owner = "Enselic";
    repo = pname;
    rev = "v${version}";
    sha256 = "0dsk77gm4cblq5q9nr8r0gzi1kf0i1jcbkn3gyl88hcn4rq79yc6";
  };
in
stdenv.mkDerivation rec {
  inherit pname;
  inherit version;

  buildInputs = [
    autoconf
    automake
    zlib           # zlib1g-dev
    xorg.libICE
    xorg.libSM
    xorg.libXext
    xorg.libXdamage
    xorg.libX11
    libogg
    libvorbis
    libtheora
    jack2          # libjack-jackd2-dev
    # libasound2-dev
    popt # libpopt-dev
  ];

  preConfigure = ''
    sh autogen.sh
    autoupdate
  '';

  # CLI
  src = "${recordmydesktop-src}/recordmydesktop";
}
