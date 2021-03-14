with import <nixpkgs> {};

(
  python38.withPackages (ps: with ps; [jinja2 sexpdata])
).env
