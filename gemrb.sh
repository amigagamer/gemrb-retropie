#!/usr/bin/env bash

# This file is part of RetroPie.
# 
# (c) Copyright 2012-2015  Florian Müller (contact@petrockblock.com)
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/petrockblog/RetroPie-Setup/master/LICENSE.md.
#

rp_module_id="gemrb"
rp_module_desc="gemrb Infinity Engine"
rp_module_menus="4+"

function depends_gemrb() {
    getDepends python-dev libopenal-dev 
}

function sources_gemrb() {
    gitPullOrClone "$md_build" git://github.com/gemrb/gemrb.git
}

function build_gemrb() {
	mkdir build
    pushd build
    cmake .. -DPREFIX="$md_inst" -DFREETYPE_INCLUDE_DIRS=/usr/include/freetype2/
    make -j 4
  #  popd
}

function install_gemrb() {
    make install
}

function configure_gemrb() {
  
    # Create startup script
    cat > "$romdir/ports/BaldursGate1.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/bg1.cfg"
_EOF_

 cat > "$romdir/ports/Planescape.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/planescape.cfg"
_EOF_
    
	
    # Set startup script permissions
    chmod u+x "$romdir/ports/BaldursGate1.sh"
    chown $user:$user "$romdir/ports/BaldursGate1.sh"


mkRomDir "gemrb"
#best way to make subdirectories?
#mkdir "$romdir/gemrb/baldurs1/"
#mkdir "$romdir/gemrb/planescape/"	
#mkdir "$romdir/gemrb/.cache/"
	#create Baldurs Gate 1 configuration
	
		#better to use iniConfig iniSet ????
		#iniConfig "=" "" "$configdir/gemrb/bg1.cfg"
		#iniSet "x" "y"
	
    cat > "$configdir/gemrb/bg1.cfg" << _EOF_
GameType=bg1
GameName=Baldur's Gate 1
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
VolumeAmbients = 100
VolumeMovie = 100
VolumeMusic = 100
VolumeSFX = 100
VolumeVoices = 100
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/retropie/roms/gemrb/baldurs1/
CD1=/home/pi/retropie/roms/gemrb/bg1/
CachePath=/home/pi/retropie/roms/gemrb/.cache/
_EOF_

	#create Planescape configuration
    cat > "$configdir/gemrb/pst.cfg" << _EOF_
GameType=pst
GameName=Planescape Torment
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
VolumeAmbients = 100
VolumeMovie = 100
VolumeMusic = 100
VolumeSFX = 100
VolumeVoices = 100
GUIEnhancements = 15
DrawFPS=1
#FogOfWar=1
CaseSensitive=1
GamePath=/home/pi/retropie/roms/gemrb/planescape/
CD1=/home/pi/retropie/roms/gemrb/pst/data/
CachePath=/home/pi/retropie/roms/gemrb/.cache/
_EOF_
	 
    
    # Add gemrb to emulationstation  TODO
    #setESSystem 'Ports' 'ports' '~/RetroPie/roms/ports' '.sh .SH' '%ROM%' 'pc' 'ports'
}
