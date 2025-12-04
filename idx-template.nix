{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [ pkgs.nodejs ];
  bootstrap = ''
    npx nativescript create myCoolApp --template vue --path "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix && chmod +w "$out"/.idx/dev.nix
    chmod -R u+w "$out"
    cp -rf ${./.idx/airules.md} "$out/.idx/airules.md"
    cp -rf "$out/.idx/airules.md" "$out/GEMINI.md"
    chmod -R u+w "$out"

    (cd "$out"; npm install --package-lock-only --ignore-scripts)
  '';
}