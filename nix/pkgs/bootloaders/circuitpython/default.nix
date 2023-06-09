{pkgs ? import <nixpkgs> {}}:
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
in {
  jpconstantineau_pykey60 = let
    board = "jpconstantineau_pykey60";
  in
    pkgs.stdenv.mkDerivation rec {
      pname = "circuitpython-${board}";
      version = "8.1.0";
      name = "circuitpython-${board}-${version}";

      src = pkgs.fetchFromGitHub {
        owner = "adafruit";
        repo = "circuitpython";
        rev = version;
        sha256 = "sha256-cS5++3lzw45ikbhVs77RRmykGXeFTJQ4wcV8eGJMxqQ";
        fetchSubmodules = true;
        leaveDotGit = true;
      };

      buildInputs = [
        gcc-arm-embedded
        gettext
        git
        gnumake
        python-with-my-packages
      ];

      buildPhase = ''
        git tag ${version}
        make -C mpy-cross
        make -C ports/raspberrypi/ BOARD=${board}
      '';

      installPhase = ''
        mkdir -p $out/
        cp ports/raspberrypi/build-jpconstantineau_pykey60/firmware.uf2 $out/
      '';
    };
}
