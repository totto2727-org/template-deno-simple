{
  lib,
  writeShellApplication,
  deno,
}:
let
  source = lib.cleanSource ./src;
in
writeShellApplication {
  name = "project";
  runtimeInputs = [ deno ];
  text = ''
    exec deno run --no-config --no-lock --cached-only ${source}/main.ts "$@"
  '';
  meta = {
    description = "A simple Deno command-line application";
    license = lib.licenses.mit;
    mainProgram = "project";
    platforms = lib.platforms.unix;
  };
}
