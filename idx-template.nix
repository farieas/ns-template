{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [ pkgs.nodejs ];
#   bootstrap = ''

#     npx nativescript create myCoolApp --template vue --path "$out"
#     mkdir "$out"/.idx
#     cp ${./dev.nix} "$out"/.idx/dev.nix && chmod +w "$out"/.idx/dev.nix
#     chmod -R u+w "$out"
#     cp -rf ${./.idx/airules.md} "$out/.idx/airules.md"
#     cp -rf "$out/.idx/airules.md" "$out/GEMINI.md"
#     chmod -R u+w "$out"
#     (cd "$out"; npm install --package-lock-only --ignore-scripts)
#   '';
bootstrap = ''
    # 1. Temporarily move to the output directory
    (cd "$out"
    # 2. Create the application using "." as the name.
    #    NativeScript will create the files directly in the current directory ("$out").
    npx nativescript create . --template vue
    )

    # 3. Rest of the script remains the same, but now it references files directly in "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix && chmod +w "$out"/.idx/dev.nix
    chmod -R u+w "$out"
    cp -rf ${./.idx/airules.md} "$out/.idx/airules.md"
    cp -rf "$out/.idx/airules.md" "$out/GEMINI.md"
    chmod -R u+w "$out"
    (cd "$out"; npm install --package-lock-only --ignore-scripts)
'';
}