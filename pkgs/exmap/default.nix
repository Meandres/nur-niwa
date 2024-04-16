{ stdenv, lib, fetchFromGitHub, nukeReferences, linuxPackages_6_8 }:

stdenv.mkDerivation rec {
    name = "exmap-${version}";
    version = "1.0";

    src = fetchFromGitHub {
      owner = "tuhhosg";
      repo = "exmap";
      rev = "6ea8f03362bc67e66196306294008b1470f03062";
      hash = "sha256-pU5do1DnyT+3NkzlRDHPKu84UEklAJhfQkaLtsCz1z8=";
    };

    kernel = linuxPackages_6_8.kernel;
    hardeningDisable = [ "pic" "format" ];
    buildInputs = [ nukeReferences ];
    nativeBuildInputs = kernel.moduleBuildDependencies;

    makeFlags = [
      "-C"
      "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      "M=$(sourceRoot)"
      "VERSION=${version}"
    ];

    buildPhase = ''
      make modules KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build -j $NIX_BUILD_CORES
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/misc
      for x in $(find . -name '*.ko'); do
        nuke-refs $x
        cp $x $out/lib/modules/${kernel.modDirVersion}/misc/
      done

      mkdir -p $out/include
      cp -r module/linux $out/include
    '';

    meta = with lib; {
      description = "ExMap - Fully explicit memory-mapped file I/O";
      homepage = "https://github.com/tuhhosg/exmap.git";
    };
}
