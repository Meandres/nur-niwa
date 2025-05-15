{ pkgs, stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "umap";
  version = "v" + "2.1.1";
  src = fetchFromGitHub {
    owner = "LLNL";
    repo = "umap";
    rev = version;
    hash = "sha256-nAzQ7fK9BsfgOSWuoQLeqomy6LO+ERP0fjj12iQXp5I=";
  };

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace 'set(CMAKE_INSTALL_PREFIX ''${CMAKE_BINARY_DIR}/install)' ""
  '';
  nativeBuildInputs = [ pkgs.cmake pkgs.gnumake ];
  patches = [ ./cstdint.patch ];

  meta = with lib; {
    homepage = https://github.com/LLNL/umap;
    description = "User-space Page Management";
    license = licenses.lgpl2;
    broken = false;
  };
}
