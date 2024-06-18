{ lib, fetchFromGitHub, fetchurl, buildGoModule, stdenv }:

buildGoModule rec {
  pname = "vhive";
  version = "v" + "1.7.1";
  src = fetchFromGitHub {
    owner = "vhive-serverless";
    repo = "vHive";
    rev = version;
    hash = "sha256-8/REu4mSajZ+XUDTBSmt2Dj2xOaglRxoMRLSARqlaCo=";
  };

  preBuild = ''
    export GOWORK=off
  '';

  excludedPackages = [
    "function-images/hello_gpu" 
    "function-images/tests/save_load_minio/client"
    "function-images/tests/save_load_minio/proto_gen"
    "function-images/tests/save_load_minio/server"
    "power_manager"
    "scripts"
  ];

  ldflags = [ "-w" ];
  doCheck = false;
  vendorHash = "sha256-5HYB45D7zfrjduvMRXw2+N9ErUSY3uhjm0NYgzMNytU=";
  #deleteVendor = true;

  meta = with lib; {
    homepage = https://vhive-serverless.github.io/;
    description = "Open-source framework for serverless experimentation ";
    license = licenses.mit;
    broken = false;
  };
}
