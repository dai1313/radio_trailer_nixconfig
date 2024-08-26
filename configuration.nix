{ modulesPath, ...}: {
    system.stateVersion = "23.11";
    imports [
        (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };
    disko.devices.disk.disk1.device = "/dev/vda";

    services.openssh.enable = true;
    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPuP75hTmr/yatbSaTA7SqiZ3mulkt3C0uu5kzzXCoj6 nixany"
    ];
