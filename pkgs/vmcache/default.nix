{ stdenv, lib, fetchgit, libaio }:

stdenv.mkDerivation rec {
  name = "vmcache-${version}";
  version = "0.1";
  src = fetchgit{
    url = "https://github.com/viktorleis/vmcache";
    rev = "94612a8993a2591ce4fe943ffb0ebe3910bf97bf";
    hash = "sha256-qHHal0Qv/pKLW4X7LIcxfvwF2ffNM/jHJHC4HkZX3kY=";
  };
  nativeBuildInputs = [ libaio ];
  patches = [ ./vmcache_pinning.patch ];

  installPhase = ''
    mkdir -p $out/bin
    cp vmcache $out/bin/vmcache
  '';

  meta = with lib; {
    homepage = https://github.com/viktorleis/vmcache;
    description = "Virtual-memory assisted buffer management";
    license = licenses.mit;
    broken = false;
  };
}
