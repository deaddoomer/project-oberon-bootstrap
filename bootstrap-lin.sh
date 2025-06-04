#!/bin/sh

set -e
if [ "$OBERON_EXE" = "" ]; then
  OBERON_EXE="oberon-07-compiler/compiler"
fi

# ==============================================================================
#  Build tools
# ==============================================================================

"$OBERON_EXE" AsciiToText.ob07 linux32exe -out AsciiToText.elf -upper -nochk bc -stk 1
"$OBERON_EXE" Compile.ob07 linux32exe -out Compile.elf -upper -nochk bc -stk 1
"$OBERON_EXE" Link.ob07 linux32exe -out LinkELF.elf -upper -nochk bc -stk 1 -def LinkTargetELF
chmod a+x AsciiToText.elf Compile.elf LinkELF.elf

# ==============================================================================
#  Convert sources and texts
# ==============================================================================

mkdir -p linux
cd linux

../AsciiToText.elf \
  ../project-oberon/Blinkers.Mod.txt           Blinkers.Mod \
  ../project-oberon/Blink.Mod.txt              Blink.Mod \
  ../project-oberon/Checkers.Mod.txt           Checkers.Mod \
  ../project-oberon/Curves.Mod.txt             Curves.Mod \
  ../project-oberon/Draw.Mod.txt               Draw.Mod \
  ../project-oberon/Draw.Tool.txt              Draw.Tool \
  ../project-oberon/EBNF.Mod.txt               EBNF.Mod \
  ../project-oberon/Edit.Mod.txt               Edit.Mod \
  ../project-oberon/Fonts.Mod.txt              Fonts.Mod \
  ../project-oberon/GraphicFrames.Mod.txt      GraphicFrames.Mod \
  ../project-oberon/Graphics.Mod.txt           Graphics.Mod \
  ../project-oberon/GraphTool.Mod.txt          GraphTool.Mod \
  ../project-oberon/Hilbert.Mod.txt            Hilbert.Mod \
  ../project-oberon/MacroTool.Mod.txt          MacroTool.Mod \
  ../project-oberon/Math.Mod.txt               Math.Mod \
  ../project-oberon/MenuViewers.Mod.txt        MenuViewers.Mod \
  ../project-oberon/ORB.Mod.txt                ORB.Mod \
  ../project-oberon/ORS.Mod.txt                ORS.Mod \
  ../project-oberon/Rectangles.Mod.txt         Rectangles.Mod \
  ../project-oberon/Sierpinski.Mod.txt         Sierpinski.Mod \
  ../project-oberon/SmallPrograms.Mod.txt      SmallPrograms.Mod \
  ../project-oberon/Stars.Mod.txt              Stars.Mod \
  ../project-oberon/TextFrames.Mod.txt         TextFrames.Mod \
  ../project-oberon/Texts.Mod.txt              Texts.Mod \
  ../project-oberon/Tools.Mod.txt              Tools.Mod \
  ../project-oberon/Viewers.Mod.txt            Viewers.Mod \
  ../project-oberon/HOST.Build.Tool.txt        Build.Tool \
  ../project-oberon/HOST386.System.Mod.txt     System.Mod \
  ../project-oberon/386.Math.Mod.txt           Math.Mod \
  ../project-oberon/386.Oberon.Mod.txt         Oberon.Mod \
  ../project-oberon/386.ORG.Mod.txt            ORG.Mod \
  ../project-oberon/386.ORP.Mod.txt            ORP.Mod \
  ../project-oberon/386.ORTool.Mod.txt         ORTool.Mod \
  ../project-oberon/LINUX386FB.Display.Mod.txt Display.Mod \
  ../project-oberon/LINUX386.FileDir.Mod.txt   FileDir.Mod \
  ../project-oberon/LINUX386.Files.Mod.txt     Files.Mod \
  ../project-oberon/LINUX386.Host.Mod.txt      Host.Mod \
  ../project-oberon/LINUX386FB.Input.Mod.txt   Input.Mod \
  ../project-oberon/LINUX386.Kernel.Mod.txt    Kernel.Mod \
  ../project-oberon/LINUX386.Modules.Mod.txt   Modules.Mod \
  ../project-oberon/LINUX386.ORL.Mod.txt       ORL.Mod \
  ../project-oberon/LINUX386.System.Tool.txt   System.Tool

# ==============================================================================
#  Copy resources
# ==============================================================================

cp ../project-oberon/LINUX386FB.readme.txt readme.txt
cp ../project-oberon/license.txt           license.txt
cp ../project-oberon/Oberon8.Scn.Fnt       Oberon8.Scn.Fnt
cp ../project-oberon/Oberon8i.Scn.Fnt      Oberon8i.Scn.Fnt
cp ../project-oberon/Oberon10.Scn.Fnt      Oberon10.Scn.Fnt
cp ../project-oberon/Oberon10b.Scn.Fnt     Oberon10b.Scn.Fnt
cp ../project-oberon/Oberon10i.Scn.Fnt     Oberon10i.Scn.Fnt
cp ../project-oberon/Oberon12.Scn.Fnt      Oberon12.Scn.Fnt
cp ../project-oberon/Oberon12b.Scn.Fnt     Oberon12b.Scn.Fnt
cp ../project-oberon/Oberon12i.Scn.Fnt     Oberon12i.Scn.Fnt
cp ../project-oberon/Oberon16.Scn.Fnt      Oberon16.Scn.Fnt
cp ../project-oberon/TTL0.Lib              TTL0.Lib
cp ../project-oberon/TTL1.Lib              TTL1.Lib

# ==============================================================================
#  Build and Link Oberon V5
# ==============================================================================

../Compile.elf \
  Kernel.Mod FileDir.Mod Files.Mod Modules.Mod \
  Host.Mod Input.Mod Display.Mod \
  Viewers.Mod Fonts.Mod Texts.Mod Oberon.Mod MenuViewers.Mod TextFrames.Mod System.Mod Edit.Mod \
  ORS.Mod ORB.Mod ORG.Mod ORP.Mod ORTool.Mod ORL.Mod \
  Graphics.Mod GraphicFrames.Mod GraphTool.Mod Rectangles.Mod Curves.Mod Draw.Mod \
  Blink.Mod Blinkers.Mod Checkers.Mod EBNF.Mod Hilbert.Mod MacroTool.Mod Math.Mod Sierpinski.Mod Stars.Mod Tools.Mod
../LinkELF.elf Modules
chmod a+x Modules.elf
mv Modules.elf oberon
