{
  lib,
  stdenv,
  fetchFromGitHub,
  pnpm_9,
  nodejs,
  npmHooks,
  writeScriptBin,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "astro-language-server";
  version = "2.11.0";

  src = fetchFromGitHub {
    owner = "withastro";
    repo = "language-tools";
    rev = "@astrojs/language-server@2.11.0";
    hash = "sha256-4+imeVjosEspFhWzjtUp2IZx7aZIx56g8M03V3dEGVs=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm_9.configHook
  ];
  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-W7BrUh0tGoG5vTuR3hXDbUTJFDiKET+QvIvCwewfZ2I=";
  };
  preBuild = ''
    rm -r vscode-client
    substituteInPlace tsconfig.json \
      --replace '{ "path": "./vscode-client" },' ""
  '';
  postBuild = ''
    pnpm run compile
    pnpm --offline deploy --frozen-lockfile  --ignore-script  --filter=bash-language-server server-deploy
  '';
  installPhase = ''
    cp -r server-deploy $out
  '';
})
