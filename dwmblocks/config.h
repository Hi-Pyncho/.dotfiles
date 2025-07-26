//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	/* {"⌨", "sb-kbselect", 0, 30}, */
  {"🔊 ", "~/.dotfiles/dwmblocks/scripts/volume.sh", 0, 5},
  {"", "~/.dotfiles/dwmblocks/scripts/keyboard-layout.sh", 0, 3},
  {"", "~/.dotfiles/dwmblocks/scripts/memory.sh", 30, 1},
  {"", "~/.dotfiles/dwmblocks/scripts/datetime.sh", 60, 2},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = "  |  ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
