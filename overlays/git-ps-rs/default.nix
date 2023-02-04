{ lib, fetchFromGitHub, rustPlatform, libgpg-error, gpgme, pkg-config, openssl, stdenv, darwin }:

let
  version = "6.4.0";
in
rustPlatform.buildRustPackage {
  pname = "git-ps-rs";
  version = version;

  src = fetchFromGitHub {
    owner = "uptech";
    repo = "git-ps-rs";
    rev = version;
    sha256 = "sha256-OWxdXXQivqLmT/8Kfc41Zz0s9GIWHH4Zp2TT1aytX0U=";
  };

  cargoSha256 = "sha256-/fFKp9qrc0BhSdWgtQaa20nMlCegZai9M0YTL29c22c=";

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
