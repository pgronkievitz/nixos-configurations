{ ... }:

{
  hardware.pulseaudio.enable = false;
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        matches = [{ "device.name" = "~bluez_card.*"; }];
        actions."update-props" = {
          "bluez5.reconnect-profiles" = [ "a2dp_sink" ];
          "bluez5.codecs" = [ "aac" ];
        };
      }
      {
        matches = [
          { "node.name" = "~bluez_input.*"; }
          { "node.name" = "~bluez_output.*"; }
        ];
        actions."node.pause-on-idle" = false;
      }
    ];
  };
}
