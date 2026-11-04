{
  lib,
  fetchFromGitHub,
  python3Packages,
  kicad,
  pybars3 ? import ../pythonPackages/pybars3 {inherit python3Packages;},
  svgpathtools ? import ../pythonPackages/svgpathtools {inherit python3Packages;},
}:
with python3Packages;
  buildPythonApplication rec {
    pname = "pcbdraw";
    version = "1.4.0";

    pyproject = true;
    build-system = [
      setuptools
      versioneer
    ];

    # fails on Windows-specific test
    doCheck = false;

    dependencies = [
      click
      lxml
      mistune
      numpy
      pillow
      pybars3
      pyyaml
      svgpathtools
    ];

    # versioneer reads the version from git metadata,
    # which the fetched source does not have.
    # Fill in the keywords that `git archive` would expand.
    postPatch = ''
      substituteInPlace pcbdraw/_version.py \
        --replace-fail 'git_refnames = "$Format:%d$"' 'git_refnames = " (tag: v${version})"'
    '';

    # PcbDraw exports the board through kicad-cli,
    # which it looks for in $KICAD_CLI before searching PATH.
    # Set a default so it uses this KiCad, and leave it overridable.
    makeWrapperArgs = [
      "--set-default"
      "KICAD_CLI"
      (lib.getExe' kicad "kicad-cli")
    ];

    # INTI-CMNB (GitHub owner of KiBot) also maintains a fork
    # https://github.com/INTI-CMNB/PcbDraw
    src = fetchFromGitHub {
      owner = "yaqwsx";
      repo = "PcbDraw";
      tag = "v${version}";
      fetchSubmodules = true;
      hash = "sha256-wLminyAG8LniYn66Z5bpLKTZkcfsK/kP7OZr5jnhV9w=";
    };
  }
