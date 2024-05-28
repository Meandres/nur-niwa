{ lib, fetchgit, buildGoModule }:

buildGoModule rec {
  name = "bima-${version}";
  version = "0.1";
  src = fetchgit{
    url = "https://github.com/nubificus/bima.git";
    rev = "8b81c9d3c2816caa80ee96fb846047369260527c";
    hash = "sha256-M133oiAPP+7HIIvGDazIr33lzRMLNbz6HyD5zmevc2k=";
  };

  vendorHash = "sha256-rhE7Xhqud71TZFUy0GXPmVpBKXcw6MXk+z5yZ5nn1x0=";

  meta = with lib; {
    homepage = https://github.com/nubificus/bima;
    description = "bima: OCI image builder for non-container software ";
    license = licenses.asl20;
    broken = false;
  };
}
