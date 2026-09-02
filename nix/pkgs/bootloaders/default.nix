{pkgs ? import <nixpkgs> {}}: {
  stm32duino = import ./stm32duino {
    inherit pkgs;
  };
}
