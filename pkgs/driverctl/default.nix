{ stdenv
, lib
, fetchFromGitLab
}:

stdenv.mkDerivation rec {
  pname = "driverctl";
  version = "0.115";

  src = fetchFromGitLab {
    owner = "driverctl";
    repo = "driverctl";
    rev = version;
    hash = "sha256-ttb2Wpyq7mb7PrnRSTMPwvd6kQUuSVBmPlP3ERsrMdA="; 
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp driverctl $out/bin/driverctl

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://gitlab.com/driverctl/driverctl";
    description = "Device driver control utility for persistent driver binding";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    broken = false;
  };
}
