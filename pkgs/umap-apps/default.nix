{ pkgs, stdenv, lib, fetchFromGitHub, umap }:

stdenv.mkDerivation rec {
  pname = "umap-apps";
  version = "v" + "1.1";
  src = fetchFromGitHub {
    owner = "LLNL";
    repo = "umap-apps";
    rev = version;
    hash = "sha256-n6UOqzfuI8DVIA7B6uYpPCpn78f+5w74pcsSYmGwHm8=";
  };
  cmakeFlags = [ "-DUMAP_INSTALL_PATH=${umap}" ];

  nativeBuildInputs = [ umap pkgs.cmake pkgs.gnumake ];
  patches = [ ./cstdint.patch ];

  meta = with lib; {
    homepage = https://github.com/LLNL/umap;
    description = "User-space Page Management";
    license = licenses.lgpl2;
    broken = false;
  };
}
