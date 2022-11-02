{ lib, fetchFromGitHub, rustPlatform, libgpg-error, gpgme, pkg-config, openssl, stdenv, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "git-ps-rs";
  version = "6.3.1";

  src = fetchFromGitHub {
    owner = "uptech";
    repo = "git-ps-rs";
    rev = version;
    sha256 = "sha256-bUwlpUDgIIZa43Qda57Pi4pwXoO8UVKz0BbYqegK/xE=";
  };

  cargoSha256 = "sha256-nqwrhteX8HlZZQA3KPJCxrcwjvciXJtBJ3JTNrLGNT4=";

  nativeBuildInputs = [
    gpgme # for gpgme-config
    libgpg-error # for gpg-error-config
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  # Needed to get openssl-sys to use pkg-config.
  OPENSSL_NO_VENDOR = 1;

  meta = with lib; {
    description = "git-ps-rs";
    homepage = "https://github.com/uptech/${pname}";
    license = licenses.unlicense;
    maintainers = [ maintainers.tailhook ];
  };
}
