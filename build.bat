@echo off

scons platform=windows target=editor steamapi=yes d3d12=yes module_mono_enabled=yes -j8
scons platform=windows target=template_debug d3d12=yes module_mono_enabled=yes -j8
;; scons platform=windows target=template_release production=yes d3d12=yes module_mono_enabled=yes -j8

bin/godot.windows.editor.x86_64.ax88m2.mono.exe --headless --generate-mono-glue modules/mono/glue

python modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows