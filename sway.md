# Installing sway

## Prerequisites (Fedora)

To make things easier, I first installed `gtk3-devel`.

* wlroots
        - Meson, ninja, cmake
        * GLES, gbm
        * libinput, libudev
        * everything xcb

* sway
        * c-json
        * libevdev
        * scdoc

* waybar
        * Gtkmm
        * jsoncpp
        * pulseaudio
        * dbusmenu-gtk3
        * libnl

* redshift
        * automake
        * autoconf
        * intltool
        * gettext-devel
        * libtool

``` {.bash #prerequisites}
sudo dnf install -y \
        meson ninja-build cmake gtk3-devel \
        mesa-libGLES-devel mesa-libgbm-devel \
        libinput-devel libudev-devel \
        libxcb-devel xcb-util-*-devel \
        json-c-devel libevdev-devel scdoc \
        gktmm30-devel jsoncpp-devel pulseaudio-libs-devel \
        libdbusmenu-gtk3-devel libnl3-devel
```

## Environment

We'll install in `/usr/local/pkg/sway` and use `stow` to create symlinks to `/usr/local`.

``` {.bash #stow}
sudo stow -d /usr/local/pkg -R sway
```

And we need to tell `pkg-config` about the location.

``` {.bash #environment}
export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig"
```

## Compiling

``` {.bash #make-install}
meson build
meson configure --prefix /usr/local/pkg/sway build
ninja -C build
sudo ninja -C bulid install
```

We need from the `swaywm` github: `wlroots`, `sway`, `swaybg`, `swaylock`. These packages use Meson for builing.

``` {.bash #install}
git clone --recursive git@github.com:swaywm/{pkg}.git
cd {pkg}
<<make-install>>
<<stow>>
cd ..
```

``` {.bash file=install-sway.sh}
<<environment>>
<<install|pkg=wlroots>>
<<install|pkg=sway>>
<<install|pkg=swaybg>>
<<install|pkg=swayidle>>
```

## Redshift

Need a new version to have wayland support.

``` {.bash #install-redshift}
git clone git@github.com:minus7/redshift.git
cd redshift
./bootstrap
./configure --prefix=/usr/local/pkg/redshift
make
sudo make install
sudo stow -d /usr/local/pkg redshift
cd ..
```
