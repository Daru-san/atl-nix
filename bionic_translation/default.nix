{lib
,fetchFromGitLab
,stdenv
,meson
,ninja
,pkg-config
,libGL
,libbsd
,libunwind
,libelf
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "bionic-translation";
  version = "0";

    #patches = [ ./remove-harfbuzz.patch ];

  src = fetchFromGitLab {
    owner = "android_translation_layer";
    repo = "bionic_translation";
    rev = "38cbae66d5c82a26e6b81c4c17733f17fada4f85";
    hash = "sha256-CHBf77YAXiOoNwZxCCSCkHOBKwQXrWrWmZyHmhsYAVI=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    libGL
    libbsd
    libunwind
    libelf
  ];

  meta = {
    description = "";
    homepage = "";
  };
})
