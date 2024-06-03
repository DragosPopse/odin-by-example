// The first statement in every odin file needs to be a "Package Declaration"
// The name of the package needs to match in every file in the same folder
// The package name is used for linking. It is prepended to the name of symbols
// NOTE: the package name doesn't need to match the folder name, and does NOT have to be called `main` for the entry package
package main

// Import the fmt package from the core collection.
// fmt contains utilities for format printing to different kinds of buffers, like consoles, strings, files, etc. 
import "core:fmt"

// Default entry point. The symbol name will be `<package-name>.<declaration-name>`, so this symbol will be named `main.main()`
main :: proc() {
	fmt.println("Hello world!") // println stands for print line. 
}

// if your cwd is in this directory, compile and run with `odin run .`
// if you are in the parent directory, `odin run hello_world`
// if you want to look at the assembly of your program, you can do `odin build hello_world -build-mode:asm`. There you'll be able to search for the `main.main` symbol as discussed earlier