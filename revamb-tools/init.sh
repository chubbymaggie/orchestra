set -e

function refresh_env {
    ENVIRONMENT_PATH="$INSTALL_PATH/../environment"
    (echo "$INSTALL_PATH/bin"; find "$INSTALL_PATH/" -name "*-gcc" -or -name "*-ld" | xargs -n1 dirname ) | sort -u | xargs echo | sed 's| |:|g; s|^|export PATH="|; s|$|:$PATH"|' > "$ENVIRONMENT_PATH"
    echo "export LD_LIBRARY_PATH=$INSTALL_PATH/lib:\$LD_LIBRARY_PATH" >> "$ENVIRONMENT_PATH"
    echo "export TOOLS_PATH=$INSTALL_PATH" >> "$ENVIRONMENT_PATH"
    echo "export DOWNLOAD_PATH=$DOWNLOAD_PATH" >> "$ENVIRONMENT_PATH"
}

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
