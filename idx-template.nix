{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [ pkgs.nodejs ];
  bootstrap = ''

    mkdir "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    shopt -s dotglob; cp -r ${./dev}/* "$out"
    npx nativescript create myCoolApp --template vue --path "$out"
    mv "$out/example"/* "$out/"
    rmdir "$out/example"
    chmod -R +w "$out"
    cd "$out"; npm install -D nativescript
    cd "$out"; npm install --package-lock-only --ignore-scripts
  '';
}