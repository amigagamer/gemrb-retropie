#!/usr/bin/env bash

# This script is for use with RetroPie.  It is not endorsed or supported by the RetroPie project.
# RetroPie copyright information follows.
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
    cmake .. -DPREFIX="$md_inst" -DCMAKE_BUILD_TYPE=Release -DFREETYPE_INCLUDE_DIRS=/usr/include/freetype2/
    make -j 4 VERBOSE=111
    popd
}

function install_gemrb() {
	pushd build
	sleep 20
	make install
	sleep 20
}

function configure_gemrb() {
  
# Create startup scripts
    cat > "$romdir/ports/BaldursGate1.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/bg1.cfg"
_EOF_

    cat > "$romdir/ports/BaldursGate2.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/bg2.cfg"
_EOF_

   cat > "$romdir/ports/Icewind1.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/iwd1.cfg"
_EOF_

   cat > "$romdir/ports/Icewind2.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/iwd2.cfg"
_EOF_


 cat > "$romdir/ports/Planescape.sh" << _EOF_
#!/bin/bash
/opt/retropie/supplementary/runcommand/runcommand.sh 0  "/opt/retropie/ports/gemrb/bin/gemrb -C /opt/retropie/configs/gemrb/planescape.cfg"
_EOF_
    
	
    # Set startup script permissions
    chmod u+x "$romdir/ports/BaldursGate1.sh"
    chown $user:$user "$romdir/ports/BaldursGate1.sh"
	chmod u+x "$romdir/ports/BaldursGate2.sh"
    chown $user:$user "$romdir/ports/BaldursGate2.sh"
	chmod u+x "$romdir/ports/Icewind1.sh"
    chown $user:$user "$romdir/ports/Icewind1.sh"
	chmod u+x "$romdir/ports/Icewind2.sh"
    chown $user:$user "$romdir/ports/Icewind2.sh"
	chmod u+x "$romdir/ports/Planescape.sh"
    chown $user:$user "$romdir/ports/Planescape.sh"
	
	mkRomDir "gemrb"
	mkRomDir "gemrb/baldurs1"
	mkRomDir "gemrb/baldurs2"
	mkRomDir "gemrb/icewind1"
	mkRomDir "gemrb/icewind2"
	mkRomDir "gemrb/planescape"	
	mkRomDir "gemrb/cache"
	mkUserDir "$configdir/gemrb"

	cp $md_inst/etc/gemrb/GemRB.cfg.sample $configdir/gemrb
	
#create Baldurs Gate 1 configuration	
    cat > "$configdir/gemrb/bg1.cfg" << _EOF_
GameType=bg1
GameName=Baldurs Gate 1
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/RetroPie/roms/gemrb/baldurs1/
CD1=/home/pi/RetroPie/roms/gemrb/baldurs1/
CachePath=/home/pi/RetroPie/roms/gemrb/cache/
_EOF_

#create Baldurs Gate 2 configuration
   cat > "$configdir/gemrb/bg2.cfg" << _EOF_
GameType=bg2
GameName=Baldurs Gate 2
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/RetroPie/roms/gemrb/baldurs2/
CD1=/home/pi/RetroPie/roms/gemrb/baldurs2/data/
CachePath=/home/pi/RetroPie/roms/gemrb/cache/
_EOF_

#create Icewind 1 configuration
   cat > "$configdir/gemrb/iwd1.cfg" << _EOF_
GameType=how
GameName=Icewind Dale 1
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/RetroPie/roms/gemrb/icewind1/
CD1=/home/pi/RetroPie/roms/gemrb/icewind1/Data/
CD2=/home/pi/RetroPie/roms/gemrb/icewind1/CD2/Data/
CD3=/home/pi/RetroPie/roms/gemrb/icewind1/CD3/Data/
CachePath=/home/pi/RetroPie/roms/gemrb/cache/
_EOF_

#create Icewind2 configuration
    cat > "$configdir/gemrb/iwd2.cfg" << _EOF_
GameType=iwd2
GameName=Icewind Dale 2
Width=800
Height=600
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/RetroPie/roms/gemrb/icewind2/
CD1=/home/pi/RetroPie/roms/gemrb/icewind2/data/
CachePath=/home/pi/RetroPie/roms/gemrb/cache/
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
GUIEnhancements = 15
DrawFPS=1
CaseSensitive=1
GamePath=/home/pi/RetroPie/roms/gemrb/planescape/
CD1=/home/pi/RetroPie/roms/gemrb/planescape/data/
CachePath=/home/pi/RetroPie/roms/gemrb/cache/
_EOF_

	chown $user:$user "$configdir/gemrb/bg1.cfg"
	chown $user:$user "$configdir/gemrb/bg2.cfg"
	chown $user:$user "$configdir/gemrb/iwd1.cfg"
	chown $user:$user "$configdir/gemrb/iwd2.cfg"
	chown $user:$user "$configdir/gemrb/pst.cfg"
	
}	
