# nixos-hypr-config

Venkatesh's NixOS configuration for the **ASUS ExpertBook P1** (`expertbook-p1`).

**Desktop:** Hyprland (Lua config) · Noctalia bar/shell · Kitty · Fish · GNOME apps

---

## Fresh Install Bootstrap

After completing a standard NixOS install and booting into a shell:

### 1. Clone this repo

The repo **must** live at `~/nixos-hypr-config` — the stow service and `nh` are configured to this path.

```bash
git clone git@github.com:venkeythemonkey/nixos-hypr-config.git ~/nixos-hypr-config
cd ~/nixos-hypr-config
```

### 2. Apply the configuration

```bash
sudo nixos-rebuild switch --flake .#expertbook-p1
```

Or with `nh` (available after the first switch):

```bash
nh os switch .
```

### 3. Reboot

```bash
reboot
```

On first login, systemd will automatically:
- Run `xdg-user-dirs-update` to create `~/Pictures/Screenshots` etc.
- Run `stow-dotfiles` to symlink all configs from `dotfiles/` into `~`
- Start Noctalia, which generates `~/.local/share/color-schemes/noctalia.colors`
  and `~/.config/kdeglobals` for Qt/Breeze theming

---

## Structure

```
flake.nix                        # Flake entrypoint — pins nixpkgs + nixpkgs-unstable
flake.lock                       # Pinned channel revisions
hosts/
  expertbook-p1/
    default.nix                  # Host imports + hostname + stateVersion
    hardware-configuration.nix   # Auto-generated hardware scan
modules/
  boot.nix                       # Bootloader, kernel
  compatibility.nix              # nix-ld for foreign binaries
  containers.nix                 # Podman + Distrobox
  desktop/
    appearance.nix               # GTK/Qt/cursor theme
    audio.nix                    # Pipewire
    browsers.nix                 # Firefox + Brave
    file-management.nix          # Nautilus, Papers, Loupe, Calculator, Disks
    fonts.nix                    # JetBrainsMono Nerd Font, Noto
    hyprland.nix                 # Hyprland, Hyprlock, Hypridle (from unstable)
    hyprland-lua-check.nix       # Build-time Lua syntax validation
    keyring.nix                  # GNOME Keyring (Secret Service)
    noctalia.nix                 # Noctalia bar + shell (from unstable)
    noctalia-config-check.nix    # Build-time Noctalia config validation
    noctalia-greeter.nix         # Noctalia login greeter (greetd)
    packages.nix                 # Desktop tools (grim, slurp, playerctl…)
    xdg.nix                      # XDG user dirs + MIME defaults
  fish.nix                       # Fish shell
  laptop.nix                     # Bluetooth, lid switch, power-profiles, fprintd
  locale.nix                     # Asia/Kolkata timezone, en_US + en_IN locales
  networking.nix                 # NetworkManager, SSH
  nix.nix                        # Flakes, nh helper, weekly GC
  packages/
    system.nix                   # Core CLI tools (git, vim, ripgrep, btop…)
  storage.nix                    # Btrfs auto-scrub, zram swap
  stow.nix                       # Systemd service to deploy dotfiles via GNU stow
  unstable.nix                   # nixpkgs-unstable overlay (pkgs.unstable.*)
  users.nix                      # Primary user account
dotfiles/                        # Stow-managed dotfiles (symlinked into ~ on login)
  fish/                          # Fish shell config
  hypr/                          # Hyprland Lua config, Hyprlock, Hypridle, scripts
  kitty/                         # Kitty terminal config
  noctalia/                      # Noctalia bar + shell config, hooks
  qtengine/                      # Qt theme config
```

---

## Dotfiles

Dotfiles are managed by **GNU stow** via a systemd user service that runs on every login.
The service restows automatically on every rebuild (via `restartTriggers`), so changes to
`dotfiles/` are picked up after `nh os switch`.

To manually restow:
```bash
systemctl --user restart stow-dotfiles
```

---

## Updating

```bash
# Update flake inputs (nixpkgs + nixpkgs-unstable)
nix flake update ~/nixos-hypr-config

# Build and switch
nh os switch ~/nixos-hypr-config
```

## Garbage Collection

Weekly GC runs automatically via `nh`, keeping the last 3 generations and any generation
from the past 7 days. To GC manually:

```bash
sudo nix-collect-garbage -d
sudo /run/current-system/bin/switch-to-configuration boot
```
