#############################################################################
#   Filename: .bash_profile                                                  #
# Maintainer: Dr Axe P <dr.axe.puli@gmail.com>                               #
#        URL: https://github.com/drAkshay/dotfiles                           #
#                                                                            #
# DISCLAIMER: Use the following code at your own discretion. I do not know   #
# of any known issues at this point. I use it mainly on OSX/bash.            #
# Some code lifted from https://natelandau.com/my-mac-osx-bash_profile/      #
#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  01.   Environment Configuration
#  02.   Make Terminal Better (remapping defaults and adding functionality)
#  03.   File and Folder Management
#  04.   Searching
#  05.   Process Management
#  06.   Networking
#  07.   System Operations & Information
#  08.   Web Development
#  09.   Custom Functions
#  10.   Reminders & Notes
#  11.   GRC COLOURIFY Alias
#  12.   git alias Mamanagement
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------

    export PS1="________________________________________________________________________________\n\[\e[0;36m\]┌─[\[\e[0m\]\[\e[1;33m\]\u\[\e[0m\]\[\e[1;36m\] @ \[\e[0m\]\[\e[1;33m\]\h\[\e[0m\]\[\e[0;36m\]]─[\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;36m\]]\[\e[0;36m\]─[\[\e[0m\]\[\e[0;31m\]\t\[\e[0m\]\[\e[0;36m\]]\[\e[0m\]\n\[\e[0;36m\]└─[\[\e[0m\]\[\e[1;37m\]\$\[\e[0m\]\[\e[0;36m\]] => \[\e[0m\] "
    export PS2="| => "

#   Export other files/settings
#   ------------------------------------------------------------
    # Source extra files when alias/functions...etc are moved out of here
    
    #for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    #[ -r "$file" ] && [ -f "$file" ] && source "$file";
    #done;
    #unset file;
    
    # could be moved to .exports
    
    # Highlight section titles in manual pages.
    export LESS_TERMCAP_md="${yellow}";

    # Don’t clear the screen after quitting a manual page.
    export MANPAGER='less -X';

#   History management
#   ------------------------------------------------------------

#   Eternal bash history.
#   -----------------------------------------------------
# Undocumented feature which sets the size to "unlimited".
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
    export SHELL_SESSION_HISTORY=0
    export HISTCONTROL=ignoreboth:erasedups
    export HISTFILESIZE=
    export HISTSIZE=
    export HISTTIMEFORMAT="%Y%m%d-%T "
    export HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'
    #export HISTTIMEFORMAT="[%F %T] "
    shopt -s histappend
    shopt -s cmdhist

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
    export HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
#    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
    
    # check the window size after each command and, if necessary,
    shopt -s checkwinsize                # update the values of LINES and COLUMNS.
# Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob
# Autocorrect typos in path names when using `cd`
    shopt -s cdspell
# Allow alias expansion in non-interactive shells
    shopt -s expand_aliases


#   iTerm2 custom title on each tab
#   ------------------------------------------------------------
    export PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'

#   Set Paths
#   ------------------------------------------------------------
#    export PATH="$PATH:/usr/local/sbin"
    export PATH="/usr/local/git/bin:/sw/bin:/usr/local/bin:/usr/local:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
#    export EDITOR=/usr/bin/nano
    export EDITOR=emacs                     # I love emacs, so here goes. Choose your poison wisely below
#    export EDITOR=vi
#    export EDITOR=vim
#    export EDITOR=pico
#    export EDITOR="open -f"
#    export EDITOR="subl -n -w"
#    export EDITOR="mate -w"
#    export EDITOR="atom --wait"

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
   export CLICOLOR=1
   export GREP_OPTIONS='--color=auto'
   
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    #export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
    colorflag="-G"
    #export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx' #red
    #export LSCOLORS=ExFxBxDxCxegedabagacad #blue
    #export LSCOLORS=Gxfxcxdxbxegedabagacad #weird light blue
    export LSCOLORS=Exfxcxdxbxegedabagacad #blue
fi

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias rm='rm -v'                            # Preferred 'rm' implementation
alias rmi='rm -iv'                          # Preferred 'rm' interactive implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias l="ls -lF ${colorflag}"
alias ll='ls -FlAhpaTOe@ ${colorflag}'      # Preferred 'll' implementation
alias ls='ls -FlhtA ${colorflag}'           # Preferred 'ls' implementation
alias lsd='ls | grep "^d"'                  # Preferred 'lsd' implementation (only directories)
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
if [[ "$OSTYPE" == "darwin"* ]]; then
       alias sed='gsed'                     # sed:          in OSX replace sed with gsed i.e gnu-sed; => brew install gnu-sed
fi                                                          #this is required since `sed -i` wont work in-place o/w on mac.
alias grep='grep --color=auto'              # grep:         Colorize the grep command output for ease of use
alias egrep='egrep --color=auto'            # egrep:        Colorize the egrep command output for ease of use
alias fgrep='fgrep --color=auto'            # fgrep:        Colorize the fgrep command output for ease of use
alias hgrep='history|grep'                  # hgrep:        grep history
alias etgrep='cat ~/.bash_eternal_history|grep'  #etgrep:   grep on external eternal history file

#alias diff='colordiff'                     # diff:         install colordiff package
alias diff='colourify diff'                 # diff:         if grc is installed use that as diff, i like colors better here

alias reload='source ~/.bash_profile'       # reload:       re-source the bash_profile
alias lreload="exec ${SHELL} -l"            # lreload:      Reload the shell (i.e. invoke as a login shell)
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'

# filetree:    Show a textual file tree of subdirectories
alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

# top-commands: show most popular commands
alias top-commands='history | awk "{print $2}" | awk "{print $1}" |sort|uniq -c | sort -rn | head -10'
#alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS="|"} {print $1}" |sort|uniq -c | sort -rn | head -10'

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

alias sudo='sudo '                         # sudo: Enable aliases to be sudo’ed

#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'   # myip:         Public facing IP Address
alias localip="ipconfig getifaddr en0"              # localip
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

alias ping='colourify ping -c 5'                    # ping:         Stop after sending count ECHO_REQUEST packets
alias fastping='ping -c 100 -s.2'                   # fastping:     Do not wait interval 1 second, go fast
alias ports='netstat -tulanp'                       # ports:        Show open ports
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"  # ifactive:  Show active network interfaces ; brew install pcre

#creating a unix version of free as explained below:
#https://apple.stackexchange.com/questions/4286/is-there-a-mac-os-x-terminal-version-of-the-free-command-in-linux-systems
#https://stackoverflow.com/questions/1250079/how-to-escape-single-quotes-within-single-quoted-strings
alias unixfree='vm_stat | perl -ne '\''/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'\'''

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
	if [[ "$OSTYPE" == "darwin"* ]]; then
	    echo -e "\n${red}Memory stats :$NC " ; unixfree  # alias unixfree as explained above for OSX
	elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	    echo -e "\n${red}Memory stats :$NC " ; free
	fi
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
	echo -e "\n${RED}Local IP Address :$NC" ;localip
	#my_ip;                                              # uncomment below if you know which en# is used for internet connectivity & modify my_ip()
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
	#echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP}
        #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP} #:."Not connected"}
        #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP}
        echo
    }

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#    Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
#   -----------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
       alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup;'
      # alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
fi

#   Lock the screen (when going AFK)
#   -----------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
      alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

# Canonical hex dump; some systems have this symlinked
# macOS has no `md5sum`, so use `md5` as a fallback
# macOS has no `sha1sum`, so use `shasum` as a fallback
#   -----------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
      command -v hd > /dev/null || alias hd="hexdump -C"
      command -v md5sum > /dev/null || alias md5sum="md5"
      command -v sha1sum > /dev/null || alias sha1sum="shasum"
fi


#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

#   ---------------------------------------
#   9.  CUSTOM FUNCTIONS
#   ---------------------------------------

welcome() {
    #------------------------------------------
    #------WELCOME MESSAGE---------------------
    # customize this first message with a message of your choice.
    # this will display the username, date, time, a calendar, the amount of users, and the up time.
    #clear
    # Gotta love ASCII art with figlet
    figlet "Welcome, " $USER;
    #toilet "Welcome, " $USER;
    echo -e ""; cal ;
    echo -ne "Today is "; date #date +"Today is %A %D, and it is now %R"
    echo -e ""
    echo -ne "Up time:";uptime | awk /'up/'
    echo -e "\n${RED}Local IP Address :$NC" ;localip
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:."Not connected"}
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP} #:."Not connected"}
    #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:."Not connected"}
    #echo -en "Local IP Address :"; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/ 
    #echo -en "Local IP Address :"; /sbin/ifconfig wlan0 | awk /'inet/ {print $2}' | sed -e s/addr://
    echo "";
}
welcome;

# get IP adresses
#function my_ip() # get IP adresses
my_ip () { 
        MY_IP=$(/sbin/ifconfig wlan0 | awk "/inet/ { print $2 } " | sed -e s/addr://)
                #/sbin/ifconfig | awk /'inet addr/ {print $2}' 
        MY_ISP=$(/sbin/ifconfig wlan0 | awk "/P-t-P/ { print $3 } " | sed -e s/P-t-P://)
}

# search history
function hs {
    grep $1 $HISTFILE
    }

#display the man page for a cmd in the Preview application
function preman() {
    man -t $@ | open -f -a "Preview"
}

#randome fact 
alias fact="echo '------------------------------------------------------------';  curl -s randomfunfacts.com | LANG=C sed -n 's/.*<i>\(.*\)<\/i>.*/\1/p'; echo '------------------------------------------------------------'"

alias week='date +%V'                           # week: # Get week number

# detect the OS and use custom commands 

#if [[ "$OSTYPE" == "linux-gnu" ]]; then
#        # ...
#elif [[ "$OSTYPE" == "darwin"* ]]; then
#        # Mac OSX
#elif [[ "$OSTYPE" == "cygwin" ]]; then
#        # POSIX compatibility layer and Linux environment emulation for Windows
#elif [[ "$OSTYPE" == "msys" ]]; then
#        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
#elif [[ "$OSTYPE" == "win32" ]]; then
#        # I'm not sure this can happen.
#elif [[ "$OSTYPE" == "freebsd"* ]]; then
#        # ...
#else
#        # Unknown
#fi

#   ---------------------------------------
#   10.  REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

#   ---------------------------------------
#   11.  GRC (COLOURIFY) alias #bre install grc
#   ---------------------------------------

#source "/usr/local/etc/grc.bashrc"

#GRC="$(which grc)"
if [ "$TERM" != dumb ]; then
    alias colourify="grc -es --colour=auto"
    alias blkid='colourify blkid'
    alias configure='colourify ./configure'
    alias df='colourify df'
    #alias diff='colourify diff'
    alias docker='colourify docker'
    alias docker-machine='colourify docker-machine'
    alias du='colourify du'
    alias env='colourify env'
    alias free='colourify free'
    alias fdisk='colourify fdisk'
    alias findmnt='colourify findmnt'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias id='colourify id'
    alias ip='colourify ip'
    alias iptables='colourify iptables'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    #alias ls='colourify ls'
    alias lsof='colourify lsof'
    alias lsblk='colourify lsblk'
    alias lspci='colourify lspci'
    alias netstat='colourify netstat'
    #alias ping='colourify ping'
    alias traceroute='colourify traceroute'
    alias traceroute6='colourify traceroute6'
    alias head='colourify head'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias mount='colourify mount'
    alias ps='colourify ps'
    alias mtr='colourify mtr'
    alias semanage='colourify semanage'
    alias getsebool='colourify setsebool'
    alias ifconfig='colourify ifconfig'
fi

#   ---------------------------
#   12.  git ALIAS MANAGEMENT
#   ---------------------------

alias co="git checkout"
alias s="echo ''; git status -sb; echo ''"
alias c="git commit"
alias cm="fact; git commit -am"
alias stage="git add ."
alias pull="git pull"
alias pullr="git pull -r"
alias push="git push"
alias ri="git rebase -i"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias branch="git branch"
alias amend="git commit --amend -m"
alias gh="hub browse"

# squashes the current changes into the previous commit
fixup() {
  local OC=`git rev-parse HEAD`
  git add -A
  git commit --fixup=$OC
  git rebase -i --autosquash $OC~1
}

# pushes the branch you are on and opens compare on github for a PR
pushpr() {
  git push -u origin `git rev-parse --abbrev-ref HEAD`
  git compare
}

pullpr() {
  git fetch origin pull/$1/head:pr-$1
  git checkout pr-$1
}

# to be run after `npm version`, pushes tags, publishes, and opens release notes
publish(){
  push && push --tags && npm publish .
  echo `git config --get remote.origin.url` | sed -e 's/\.git/\/releases/g' | echo "`cat -`/new?tag=`git describe`" | xargs open
}