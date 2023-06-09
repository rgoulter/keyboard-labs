{
  lib,
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "qrcodegen";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "nayuki";
    repo = "QR-Code-generator";
    rev = "v${version}";
    sha256 = "sha256-WH6O3YE/+NNznzl52TXZYL+6O25GmKSnaFqDDhRl4As=";
  };

  preBuild = ''
    cd python/
  '';

  meta = with lib; {
    homepage = "https://www.nayuki.io/page/qr-code-generator-library";
    description = "High quality QR Code generator library for Python";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
