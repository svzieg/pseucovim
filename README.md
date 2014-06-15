#pseucovim


PseuCo Plugin for Vim. See more informations about pseuco on pseuco.com. 
You can download the PseuCo Compiler at:  http://pseuco.de/downloads/Tools/PseuCoCo-1.6.zip



###About pseucovim

pseucovim is a plugin for Vim that support PseuCo-Syntaxhighlining (in all .pseuco files) , and a compile-Command. There's no autocompletion so far but I'm hanging on it ;) so please be patient.

###Compiler Options

So far the only option you have to set is the compile command. For those who use Pseuco daily and just added PseuCoCo as "pseuco" to their $PATH-Enviroment can skip these step.

For all the other (I think that would be the most of you) you have to set the "g:pseuco_command" to your compiler.
Example:
If you use the Compiler I mensioned before you just have to add:

    let  g:pseuco_command="java -jar /absolute/path/to/PseuCoCo.jar"

in your vimrc


Now you can compile and run your .pseuco File with

    :PseuCoCompileAndRun

####Feedback and Issues
If you have found any issus or missing a function use the bugtracker of github ;)
