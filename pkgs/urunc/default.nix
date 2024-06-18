{ lib, fetchgit, fetchurl, buildGoModule, stdenv }:

#buildGoModule rec {
stdenv.mkDerivation rec {
  name = "urunc-${version}";
  version = "0.2.0";
  srcs = [ 
    (fetchurl {
        url = "https://github.com/nubificus/urunc/releases/download/v0.2.0/urunc_amd64";
        hash = "sha256-Bo34E7alpKREOAVRtmYdHbDB7PysYgTa0SejBSOIJ+c=";
    })
    (fetchurl {
        url = "https://github.com/nubificus/urunc/releases/download/v0.2.0/containerd-shim-urunc-v2_amd64";
        hash = "sha256-FCmEUQLLGTHYKvkQMf92cSypiAlUn3nPDHQL331XYzs=";
    })];
  #src = fetchgit{
  #  url = "https://github.com/nubificus/urunc.git";
  #  rev = "b897d271d43185bdf9164bf570d16cbc1b2110df";
  #  hash = "sha256-ONHOcmQw5+ksqpMh3dcSkemPt32AGdrr3dCAiiYghh4=";
  #};

  #doCheck = false;
  #vendorHash = "sha256-yucUMVVmDmeR4k7UQ3RZuYV3Lg9YNT+jdt+k0dIcr9s=";

  installPhase = ''
    mkdir -p $out
    cp urunc_amd64 $out/bin/urunc
    cp containerd-shim-urunc-v2_amd64 $out/bin/containerd-shim-urunc-v2
  '';
  
  meta = with lib; {
    homepage = https://github.com/nubificus/urunc;
    description = "a simple container runtime that aspires to become `runc` for unikernels";
    license = licenses.asl20;
    broken = false;
  };
}
