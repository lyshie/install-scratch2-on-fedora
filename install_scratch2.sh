#!/bin/sh

# Created by HSIEH, Li-Yi (lyshie@tn.edu.tw)
#
# How to install dependencies:
# http://www.zealfortechnology.com/2012/05/install-adobe-air-on-fedora.html
# https://aur.archlinux.org/packages/adobe-air-sdk
# https://aur.archlinux.org/packages/scratch2/

# Adobe Air installation path
AIR_FILE="/tmp/AdobeAIRSDK.tbz2"
AIR_TARGET="/opt/adobe-air-sdk"

# Scratch2 installation path
SCRATCH2_VERSION="453"
SCRATCH2_FILE="Scratch-${SCRATCH2_VERSION}.air"
SCRATCH2_TARGET="/opt/airapps/scratch2"

# Download Adobe AIR SDK (and runtime)
# Adobe AIR 2.6 runtime downloads
# https://helpx.adobe.com/air/kb/archived-air-sdk-version.html
wget -q "http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRSDK.tbz2" -O "${AIR_FILE}"

# Check if target exists
if [ -d "${AIR_TARGET}" ]; then
    # backup and rename
    mv "${AIR_TARGET}" "${AIR_TARGET}.bak"
fi

# Extract files into target
mkdir -p "${AIR_TARGET}"
tar xvjf "${AIR_FILE}" -C "${AIR_TARGET}"
# Create runtime files
ln -fs "${AIR_TARGET}/runtimes/air/linux/Adobe AIR" /opt/

# Download Scratch 2 Offline Editor
# The current version is 453.
# https://scratch.mit.edu/scratch2download/
wget -q --no-check-certificate "https://scratch.mit.edu/scratchr2/static/sa/Scratch-${SCRATCH2_VERSION}.air" -O "${SCRATCH2_FILE}"

# Check if target exists
if [ -d "${SCRATCH2_TARGET}" ]; then
    # backup and rename
    mv "${SCRATCH2_TARGET}" "${SCRATCH2_TARGET}.bak"
fi

# Extract files into target
mkdir -p "${SCRATCH2_TARGET}"
unzip "${SCRATCH2_FILE}" -d "${SCRATCH2_TARGET}"

# Create an executable command
cat << EOF > "/usr/local/bin/scratch2"
#!/bin/sh
${AIR_TARGET}/bin/adl -nodebug ${SCRATCH2_TARGET}/META-INF/AIR/application.xml ${SCRATCH2_TARGET}
EOF

chmod a+x "/usr/local/bin/scratch2"
