{
  pkgs ? import <nixpkgs> {},
  gcc-arm-a-embedded ? pkgs.callPackage ../../pkgs/gcc-arm-a-embedded {},
}:
with pkgs; let
  cascadetoml = python3.pkgs.buildPythonPackage rec {
    pname = "cascadetoml";
    version = "0.3.3";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-wV3SR/g+wIel+R/oC+gyEWq93eZ7yigBiqX6envgE4c";
    };

    format = "pyproject";

    propagatedBuildInputs = with python3.pkgs; [
      flit-core
      parse
      tabulate
      tomlkit
      typer
    ];

    # doCheck = false;

    meta = with lib; {
      homepage = "https://github.com/adafruit/cascadetoml";
      description = "Command for cascading toml files together";
      license = licenses.mit;
      maintainers = with maintainers; [];
    };
  };
  huffman = python3.pkgs.buildPythonPackage rec {
    pname = "huffman";
    version = "0.1.2";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "08fdd5ef7c96480ad11c12d472de21acd32359996f69a5259299b540feba4560";
    };

    doCheck = false;

    meta = with lib; {
      homepage = "https://github.com/nicktimko/huffman";
      description = "Generate Huffman codebooks";
      license = licenses.mit;
      maintainers = with maintainers; [];
    };
  };
in let
  my-python-packages = python-packages:
    with python-packages; [
      cascadetoml
      huffman
      jinja2
    ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  mkShell {
    buildInputs = [
      gcc-arm-embedded
      gcc-arm-a-embedded
      gettext
      git
      gnumake
      python-with-my-packages
    ];
  }
