{pkgs ? import <nixpkgs> {}}: {
  circuitpython = import ./circuitpython {
    inherit pkgs;
  };
  stm32duino = import ./stm32duino {
    inherit pkgs;
  };
  tinyuf2 = import ./tinyuf2 {
    inherit pkgs;
  };
}
