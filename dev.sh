#!bash
git pull
export BIN="/Applications/Godot v4.6.app/Contents/MacOS/Godot"
echo $BIN project.godot
"$BIN" project.godot
git add . && git commit -a -m "Saving your bacon" && git push
