{ stdenv, pulseaudioSupport ? stdenv.isLinux , callPackage, wineBuild }:

rec {
  fonts = callPackage ./wine/fonts.nix {};
  minimal = callPackage ./wine {
    wineRelease = "wayland";
    inherit wineBuild;
  };

  base = minimal.override {
    pngSupport = true;
    jpegSupport = true;
    tiffSupport = true;
    gettextSupport = true;
    fontconfigSupport = true;
    alsaSupport = true;
    openglSupport = true;
    vulkanSupport = stdenv.isLinux;
    tlsSupport = true;
    cupsSupport = true;
    dbusSupport = true;
    cairoSupport = true;
    cursesSupport = true;
    saneSupport = true;
    pulseaudioSupport = pulseaudioSupport;
    udevSupport = true;
    xineramaSupport = true;
    xmlSupport = true;
    sdlSupport = true;
    mingwSupport = true;
  };

  full = base.override {
    gtkSupport = true;
    gstreamerSupport = true;
    colorManagementSupport = true;
    mpg123Support = true;
    openalSupport = true;
    openclSupport = true;
    odbcSupport = true;
    netapiSupport = true;
    vaSupport = true;
    pcapSupport = true;
    v4lSupport = true;
    gsmSupport = true;
    gphoto2Support = true;
    ldapSupport = true;
    faudioSupport = true;
    vkd3dSupport = true;
    embedInstallers = true;
  };
}
