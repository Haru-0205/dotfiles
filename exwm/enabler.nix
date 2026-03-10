{ pkgs, ... }:
{
  services.xserver.windowManager.exwm = {
    enable = true;
  };
}
