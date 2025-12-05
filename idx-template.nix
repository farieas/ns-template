{ pkgs, ... }: {
  channel = "stable-25.05";
  packages = [ 
    pkgs.nodejs_24 
    pkgs.python313
    pkgs.python313Packages.pip
    pkgs.python313Packages.fastapi
    pkgs.python313Packages.uvicorn
    pkgs.ruby
   ];
    bootstrap = ''
    mkdir -p "$WS_NAME"
    npx nativescript-vue create $WS_NAME --vue
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"

    chmod -R u+w "$out"
    cd "$out"; npm install -D nativescript
    cd "$out"; npm install --package-lock-only --ignore-scripts --legacy-peer-deps
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
  #   cd "$out"; npm install -D nativescript
  #   cd "$out"; npm install --package-lock-only --ignore-scripts --legacy-peer-deps
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