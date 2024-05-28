{ lib, fetchgit, buildGoModule }:

buildGoModule rec {
  name = "urunc-${version}";
  version = "0.2.0";
  src = fetchgit{
    url = "https://github.com/nubificus/urunc.git";
    rev = "b897d271d43185bdf9164bf570d16cbc1b2110df";
    hash = "sha256-ONHOcmQw5+ksqpMh3dcSkemPt32AGdrr3dCAiiYghh4=";
  };

  doCheck = false;
  vendorHash = "sha256-yucUMVVmDmeR4k7UQ3RZuYV3Lg9YNT+jdt+k0dIcr9s=";
  
  meta = with lib; {
    homepage = https://github.com/nubificus/urunc;
    description = "a simple container runtime that aspires to become `runc` for unikernels";
    license = licenses.asl20;
    broken = false;
  };
}
