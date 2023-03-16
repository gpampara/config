{ lib, fetchFromGitHub, rustPlatform, libgpg-error, gpgme, pkg-config, openssl, stdenv, darwin }:

let
  version = "6.5.0";
in
rustPlatform.buildRustPackage {
  pname = "git-ps-rs";
  version = version;

  src = fetchFromGitHub {
    owner = "uptech";
    repo = "git-ps-rs";
    rev = version;
    sha256 = "sha256-4wSm3H+98ZJZ+fZdLYshPKafRkPq98Pv3Lwh9o0be6U=";
  };

  cargoSha256 = "sha256-1p46xvo7abMPlVP8BeQ1j/8QQpK3kCgbTL3cdidfq04=";

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
