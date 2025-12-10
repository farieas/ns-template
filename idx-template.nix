{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = [ 
    pkgs.nodejs
    
   ];
   bootstrap = ''
  set -e
  set -o pipefail

  echo "▶ Bootstrapping project..."
  echo "Template: ${template}"
  echo "TypeScript: ${if ts then "yes" else "no"}"

  # -----------------------------
  # Directories
  # -----------------------------
  mkdir -p "$out/.idx"
  cp ${./dev.nix} "$out/.idx/dev.nix"

  if [ -d ${./dev} ]; then
    cp -r ${./dev}/. "$out/"
  fi

  chmod -R +w "$out"
  cd "$out"

  # -----------------------------
  # Node / NPM sanity
  # -----------------------------
  export npm_config_loglevel=warn
  export npm_config_fund=false
  export npm_config_audit=false

  # Local project npm config (NOT global)
  npm config set legacy-peer-deps true --location=project

  # -----------------------------
  # Versions (PIN THEM)
  # -----------------------------
  NS_VERSION="8.6.5"

  # -----------------------------
  # Install NativeScript CLI locally
  # -----------------------------
  npm init -y >/dev/null 2>&1

  npm install -D nativescript@"$NS_VERSION"

  NS="./node_modules/.bin/ns"

  # -----------------------------
  # Project creation
  # -----------------------------
  if [ "${template}" = "svelte" ]; then
    echo "▶ Creating NativeScript Svelte app"
    npx --yes @nativescript/cli@"$NS_VERSION" create app \
      --template @nativescript/template-blank-svelte \
      --path "$out"
  else
    echo "▶ Creating NativeScript ${template} app"
    "$NS" create app \
      --"${template}" \
      ${if ts then "--ts" else ""} \
      --path "$out"
  fi

  # -----------------------------
  # Permissions (Nix safety)
  # -----------------------------
  chmod -R +w "$out"

  # -----------------------------
  # Final dependency install
  # -----------------------------
  echo "▶ Installing dependencies"
  npm install

  echo "✅ Bootstrap completed successfully"
'';



}
