{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [ 
    pkgs.nodejs
    
   ];
    bootstrap = ''
    mkdir -p "$WS_NAME"
    npm config set legacy-peer-deps true
    npm install nativescript 
    ./node_modules/nativescript/bin/ns create "$WS_NAME" --svelte
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"

    chmod -R u+w "$out"
    cd "$out"; npm install --package-lock-only --ignore-scripts --legacy-peer-deps true
  '';

# working
  #     bootstrap = ''
  #   mkdir -p "$WS_NAME"
  #   npx nativescript create $WS_NAME --template @nativescript-vue/template-blank@latest
  #   mkdir -p "$WS_NAME/.idx/"
  #   cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
  #   chmod -R +w "$WS_NAME"
  #   mv "$WS_NAME" "$out"

  #   chmod -R u+w "$out"
  #
  #   cd "$out"; npm install --package-lock-only --ignore-scripts --legacy-peer-deps true
  # '';
#   bootstrap = ''
    
#     npx nativescript create sample --template vue --path "$out"
#     mkdir "$out"/.idx
#     cp ${./dev.nix} "$out"/.idx/dev.nix && chmod +w "$out"/.idx/dev.nix
#     chmod -R u+w "$out"
#     cp -rf ${./.idx/airules.md} "$out/.idx/airules.md"
#     cp -rf "$out/.idx/airules.md" "$out/GEMINI.md"
#     chmod -R u+w "$out"
#     (cd "$out"; npm install --package-lock-only --ignore-scripts)
#   '';

}
