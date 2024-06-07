{
  lib,
  stdenv,
  fetchurl,
  ncurses5,
  python311,
  libxcrypt-legacy,
  runtimeShell,
}:
stdenv.mkDerivation rec {
  pname = "gcc-arm-a-embedded";
  version = "10.3-2021.07";

  platform =
    {
      aarch64-darwin = "darwin-arm64";
      aarch64-linux = "aarch64";
      x86_64-darwin = "darwin-x86_64";
      x86_64-linux = "x86_64";
    }
    .${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  src = fetchurl {
    url = "https://developer.arm.com/-/media/Files/downloads/gnu-a/${version}/binrel/gcc-arm-${version}-${platform}-aarch64-none-elf.tar.xz";
    sha256 =
      {
        x86_64-linux = "sha256-b3Sx7jcMrrcWaI0uRn5bRHJ/3A7VYCP+XHLAYgAZ7O8";
      }
      .${stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  preFixup = ''
    find $out -type f | while read f; do
      patchelf "$f" > /dev/null 2>&1 || continue
      patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" || true
      patchelf --set-rpath ${lib.makeLibraryPath ["$out" stdenv.cc.cc ncurses5 python311 libxcrypt-legacy]} "$f" || true
    done
  '';

  postFixup = ''
    ls -al $out/bin/aarch64-none-elf-gdb
    mv $out/bin/aarch64-none-elf-gdb $out/bin/aarch64-none-elf-gdb-unwrapped
    cat <<EOF > $out/bin/aarch64-none-elf-gdb
    #!${runtimeShell}
    export PYTHONPATH=${python311}/lib/python3.11
    export PYTHONHOME=${python311}/bin/python3.11
    exec $out/bin/aarch64-none-elf-gdb-unwrapped "\$@"
    EOF
    chmod +x $out/bin/aarch64-none-elf-gdb
  '';

  meta = with lib; {
    description = "Pre-built GNU toolchain from ARM Cortex-A processors";
    homepage = "https://developer.arm.com/open-source/gnu-toolchain/gnu-a";
    license = with licenses; [bsd2 gpl2 gpl3 lgpl21 lgpl3 mit];
    maintainers = with maintainers; [];
    platforms = ["x86_64-linux"];
    sourceProvenance = with sourceTypes; [binaryNativeCode];
  };
}
