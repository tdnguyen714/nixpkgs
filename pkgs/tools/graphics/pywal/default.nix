{ lib, python3Packages, imagemagick, feh }:

python3Packages.buildPythonApplication rec {
  pname = "pywal";
  version = "2.0.5";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "117f61db013409ee2657aab9230cc5c2cb2b428c17f7fbcf664909122962165e";
  };

  # necessary for imagemagick to be found during tests
  buildInputs = [ imagemagick ];

  makeWrapperArgs = [ "--prefix PATH : ${lib.makeBinPath [ imagemagick feh ]}" ];

  preCheck = ''
    mkdir tmp
    HOME=$PWD/tmp
  '';

  meta = with lib; {
    description = "Generate and change colorschemes on the fly. A 'wal' rewrite in Python 3.";
    homepage = https://github.com/dylanaraps/pywal;
    license = licenses.mit;
    maintainers = with maintainers; [ Fresheyeball ];
  };
}
