{ ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "kleha";
		settings = {
      devices = {
        "SC-53C" = { id = "7IHYNKN-PNA26AJ-FTXD4XK-SLCL26Q-ZATCRVB-DHBNAPI-NAHSBJI-VL6XBQQ"; };
      };
			folders = {
				"/home/kleha/Documents/syncthing/keepass" = {
					id = "keepass";
          devices = [ "SC-53C" ];
				};
				"/home/kleha/working/klef-learning/cource" = {
					id = "klef-learning-cource";
          devices = [ "SC-53C" ];
				};
				"/home/kleha/knowledge/org" = {
					id = "knowledge-org";
          devices = [ "SC-53C" ];
				};
				"/home/kleha/knowledge/obsidian" = {
					id = "knoledge-obsidian";
          devices = [ "SC-53C" ];
				};
			};
		};
		dataDir = "/home/kleha";
		configDir = "/home/kleha/.config/syncthing";
  };
}
