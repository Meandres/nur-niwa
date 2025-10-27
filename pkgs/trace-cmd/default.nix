{ stdenv, lib, fetchzip, pkg-config, libtraceevent, libtracefs, zstd }:

stdenv.mkDerivation rec {
  name = "trace-cmd-${version}";
  version = "v3.3.3";
  src = fetchzip {
    url = "https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/trace-cmd-${version}.tar.gz";
    hash = "sha256-B3bwHV+f6IuoNESz5B4ij5KsIcCcpUPmoSnJeJj0J0Y=";
  };
  buildInputs = [ pkg-config libtraceevent libtracefs zstd ];
  
  buildPhase = ''
    mkdir -p $out
    make prefix=$out
  '';

  installPhase = ''
    make prefix=$out install
  '';

  meta = with lib; {
    homepage = https://www.trace-cmd.org;
    description = "Front-end application to Ftrace";
    license = licenses.gpl2;
    broken = false;
  };
}
