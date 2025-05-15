{ rustPlatform, lib, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "tpchgen-rs-${version}";
  version = "v1.1.0";
  src = fetchFromGitHub {
    owner = "clflushopt";
    repo = "tpchgen-rs";
    rev = version;
    hash = "sha256-akW2hexVv9g1B9oPF7ldvgfrmrPF+c11ZxNqFkYNWrM=";
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  cargoHash = "";
  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    homepage = "https://datafusion.apache.org/blog/2025/04/10/fastest-tpch-generator/";
    description = "TPC-H benchmark data generation in pure Rust ";
    license = licenses.asl20;
    broken = false;
  };
}
