{
  lib,
  stdenv,
  fetchFromGitLab,
  wolfssl,
  bionic-translation,
  python3,
  which,
  jdk17,
  zip,
  xz,
  icu,
  zlib,
  libcap,
  expat,
  openssl,
  libbsd,
  lz4,
  runtimeShell,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "art-standalone";
  version = "0";

  patches = [ ./add-liblog-dep.patch ];

  src = fetchFromGitLab {
    owner = "android_translation_layer";
    repo = "art_standalone";
    rev = "aa709f68d03e83d35c5e8a58e77760e5be9185bc";
    hash = "sha256-YNAXbtcaZHWaFPbJ+wUFfuHAwU3HrwF6tx6lQzlkWZA=";
  };

  enableParallelBuilding = true;

  strictDeps = true;

  nativeBuildInputs = [
    python3
    which
    jdk17
    zip
  ];

  buildInputs = [
    wolfssl
    xz
    icu
    zlib
    libcap
    expat
    openssl
    libbsd
    lz4
    bionic-translation
  ];

  postPatch = ''
    chmod +x dalvik/dx/etc/{dx,dexmerger}
    patchShebangs .
    sed -i "s|/bin/bash|${runtimeShell}|" build/core/config.mk build/core/main.mk
  '';

  makeFlags = [
    "____LIBDIR=lib"
    "____PREFIX=${placeholder "out"}"
    "____INSTALL_ETC=${placeholder "out"}/etc"
  ];

  meta = {
    description = "";
    homepage = "";
  };
})
