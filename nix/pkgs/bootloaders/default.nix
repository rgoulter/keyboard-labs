{pkgs ? import <nixpkgs> {}}: {
  stm32duino = import ./stm32duino {
    inherit pkgs;
  };
  tinyuf2 = import ./tinyuf2 {
    inherit pkgs;
  };
}
