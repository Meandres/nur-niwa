{ stdenv, lib, fetchFromGitLab, makeWrapper, kmod, pciutils, systemd, coreutils, gawk }:

stdenv.mkDerivation rec {
  pname = "driverctl";
  version = "0.115";

  src = fetchFromGitLab {
    owner = "driverctl";
    repo = "driverctl";
    rev = version;
    hash = "sha256-ttb2Wpyq7mb7PrnRSTMPwvd6kQUuSVBmPlP3ERsrMdA=";
  };

  nativeBuildInputs = [ makeWrapper ];

  postPatch = ''
    substituteInPlace driverctl \
      --replace "/sbin/modprobe" "modprobe" \
      --replace "/sbin/udevadm" "udevadm" \
      --replace "/usr/sbin/udevadm" "udevadm"
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    
    # install -D creates the directory and sets permissions in one go
    install -Dm755 driverctl $out/bin/driverctl
    
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/driverctl \
      --prefix PATH : ${lib.makeBinPath [ kmod pciutils systemd coreutils gawk ]}
  '';

  meta = with lib; {
    homepage = "https://gitlab.com/driverctl/driverctl";
    description = "Device driver control utility for persistent driver binding";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    mainProgram = "driverctl";
  };
}
