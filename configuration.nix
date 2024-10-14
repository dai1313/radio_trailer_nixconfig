{ modulesPath, config, pkgs, ... }: {
    imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    disko.devices.disk.disk1.device = "/dev/vda";

# Enable the OpenSSH daemon.
    services.openssh.settings.PermitRootLogin = "yes";
    services.openssh.enable = true;
    users.users.root = {
        hashedPassword = "$6$iUDCRp8gZVWJQxqz$VePMbNyDPTGYf6gnzLVJtZXTyhLJFVj5vNGnsKHpV8EMoyDhrar8K/MIyNMxau3aZ9Nk55.o0ZYsWPvsO0Imh1";
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFbzovA+t7Ifr+5AtngZjqdUiN0Ma/og8KL6gOS5myld radio@nixos"
        ];
    };

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.radio = {
        isNormalUser = true;
        description = "radio";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
#  thunderbird
        ];
# Created using mkpasswd
        hashedPassword = "$6$iUDCRp8gZVWJQxqz$VePMbNyDPTGYf6gnzLVJtZXTyhLJFVj5vNGnsKHpV8EMoyDhrar8K/MIyNMxau3aZ9Nk55.o0ZYsWPvsO0Imh1";
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFbzovA+t7Ifr+5AtngZjqdUiN0Ma/og8KL6gOS5myld radio@nixos"
        ];
    };


    networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


# Enable networking
        networking.networkmanager.enable = true;

#networking.interfaces.eth0.ipv4.addresses = [ {
#  address = "192.168.122.15";
#  prefixLength = 24;
#} ];

# Set your time zone.
    time.timeZone = "America/New_York";

# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

# Enable the X11 windowing system.
    services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

# Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

# Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "radio";

# Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

# Install firefox.
    programs.firefox.enable = true;

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        nixos-install-tools
            nixos-anywhere
            curl
            git
            vim 
    ];


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:


# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
                                    }
