{ lib, fetchFromGitHub, fetchurl, buildGoModule, stdenv }:

buildGoModule rec {
  pname = "firecracker-containerd";
  version = "0.1";
  src = fetchFromGitHub {
    owner = "vhive-serverless";
    repo = "firecracker-containerd";
    rev = "3fae0bdd0f592581a2e0519fd6c307b8549569f8";
    hash = "sha256-e3b9e11PBCGXuQtsrO5deNYdiEZIRSPdsex3fn/b4nU=";
  };

  subPackages = [
    "firecracker-control/cmd/containerd"
    "agent"
    "runtime"
  ];

  postBuild = ''
    set -x
    CGO_ENABLED=0 buildGoDir install ./agent
    set +x
  '';

  postInstall = ''
    mv $out/bin/{runtime,containerd-shim-aws-firecracker}
  '';

  doCheck = false;
  vendorHash = "sha256-IY3YMQMJrxUbKLoY+PJj6JwXd2BtC37vMQPyZlHhpBk=";

  meta = with lib; {
    homepage = https://vhive-serverless.github.io/;
    description = "firecracker-containerd enables containerd to manage containers as Firecracker microVMs";
    license = licenses.asl20;
    broken = false;
  };
}
