set -e

JOBS="${JOBS:-$(( $(nproc) / 2 ))}"
if [ "$JOBS" -lt 1 ]; then
    JOBS=1
fi
REVAMB_TOOLS="${REVAMB_TOOLS:-${XDG_CACHE_HOME:-$HOME/.cache}/revamb-tools}"
mkdir -p "$REVAMB_TOOLS"

INSTALL_PATH="${INSTALL_PATH:-$REVAMB_TOOLS/root}"
mkdir -p "$INSTALL_PATH"

DOWNLOAD_PATH="$REVAMB_TOOLS/download"
mkdir -p "$DOWNLOAD_PATH"

CONFIGS=(default gc_o0 gc_o1 gc_o2 gc_o3)
CFLAGS_default=""
GC="-Wl,--gc-sections -ffunction-sections"
CFLAGS_gc_o0="$GC -O0"
CFLAGS_gc_o1="$GC -O1"
CFLAGS_gc_o2="$GC -O2"
CFLAGS_gc_o3="$GC -O3"
