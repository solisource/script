# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f /ecad/bashrc.alias ]; then
	. /ecad/bashrc.alias
fi
if [ -f /ecad/bashrc.ecad ]; then
	. /ecad/bashrc.ecad
fi

## Define colors
txtblk=$'\[\e[0;30m\]' # Black - Regular
txtred=$'\[\e[0;31m\]' # Red
txtgrn=$'\[\e[0;32m\]' # Green
txtylw=$'\[\e[0;33m\]' # Yellow
txtblu=$'\[\e[0;34m\]' # Blue
txtpur=$'\[\e[0;35m\]' # Purple
txtcyn=$'\[\e[0;36m\]' # Cyan
txtwht=$'\[\e[0;37m\]' # White

bldblk=$'\[\e[1;30m\]' # Black - Bold
bldred=$'\[\e[1;31m\]' # Red
bldgrn=$'\[\e[1;32m\]' # Green
bldylw=$'\[\e[1;33m\]' # Yellow
bldblu=$'\[\e[1;34m\]' # Blue
bldpur=$'\[\e[1;35m\]' # Purple
bldcyn=$'\[\e[1;36m\]' # Cyan
bldwht=$'\[\e[1;37m\]' # White

unkblk=$'\[\e[4;30m\]' # Black - Underline
undred=$'\[\e[4;31m\]' # Red
undgrn=$'\[\e[4;32m\]' # Green
undylw=$'\[\e[4;33m\]' # Yellow
undblu=$'\[\e[4;34m\]' # Blue
undpur=$'\[\e[4;35m\]' # Purple
undcyn=$'\[\e[4;36m\]' # Cyan
undwht=$'\[\e[4;37m\]' # White

bakblk=$'\[\e[40m\]'   # Black - Background
bakred=$'\[\e[41m\]'   # Red
badgrn=$'\[\e[42m\]'   # Green
bakylw=$'\[\e[43m\]'   # Yellow
bakblu=$'\[\e[44m\]'   # Blue
bakpur=$'\[\e[45m\]'   # Purple
bakcyn=$'\[\e[46m\]'   # Cyan
bakwht=$'\[\e[47m\]'   # White

txtrst=$'\[\e[0m\]'    # Text Reset

## Bash allows these prompt strings to be customized by inserting a
## number of backslash-escaped special characters that are
## decoded as follows:
## 
##   \a         an ASCII bell character (07)
##   \d         the date in "Weekday Month Date" format (e.g., "Tue May 26")
##   \D{format} the format is passed to strftime(3) and the result
##              is inserted into the prompt string an empty format
##              results in a locale-specific time representation.
##              The braces are required
##   \e         an ASCII escape character (033)
##   \h         the hostname up to the first `.'
##   \H         the hostname
##   \j         the number of jobs currently managed by the shell
##   \l         the basename of the shell's terminal device name
##   \n         newline
##   \r         carriage return
##   \s         the name of the shell, the basename of $0 (the portion following
##              the final slash)
##   \t         the current time in 24-hour HH:MM:SS format
##   \T         the current time in 12-hour HH:MM:SS format
##   \@         the current time in 12-hour am/pm format
##   \A         the current time in 24-hour HH:MM format
##   \u         the username of the current user
##   \v         the version of bash (e.g., 2.00)
##   \V         the release of bash, version + patch level (e.g., 2.00.0)
##   \w         the current working directory, with $HOME abbreviated with a tilde
##   \W         the basename of the current working directory, with $HOME
##              abbreviated with a tilde
##   \!         the history number of this command
##   \#         the command number of this command
##   \$         if the effective UID is 0, a #, otherwise a $
##   \nnn       the character corresponding to the octal number nnn
##   \\         a backslash
##   \[         begin a sequence of non-printing characters, which could be used
##              to embed a terminal control sequence into the prompt
##   \]         end a sequence of non-printing characters

## Parses out the branch name from .git/HEAD: //For git Promb
get_vcs_branch () {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            branch="Git.branch->empty"
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                branch="${head#*/*/}"
                branch="Git.branch->$branch"
            elif [[ $head != '' ]]; then
                branch="detached"
                branch="Git.branch->$branch"
            fi
            return
        fi
        if [ -f "$dir/.hg/requires" ]; then
            branch="Hg.branch->empty"
            if [ -f "$dir/.hg/undo.branch" ]; then
                branch=`cat $dir/.hg/undo.branch`
                branch="Hg.branch->$branch"
            elif [ -f "$dir/.hg/branch" ]; then
                branch=`cat $dir/.hg/branch`
                branch="Hg.branch->$branch"
            fi
            return
        fi
        dir="../$dir"
    done
    branch='non-vcs-rep'
}

#PS1="[\u@\h:\w]" 
#PS1="\[\e[31;5m\][\u@\H:\w]#"
case `id -u` in
  0) export PS1="\[\e[0;31m\]\u\[\e[m\]@\[\e[0;32m\]\H\[\e[m\]:\[\e[0;33m\]\w\[\e[m\]->\[\e[0;35m\]";;
  *) export PS1="\[\e[0;31m\]\u\[\e[m\]@\[\e[0;32m\]\H\[\e[m\]:\[\e[0;33m\]\w\[\e[m\]>>\[\e[0;35m\]";;
esac

case `id -u` in
  0) export PS1="$txtred\u$txtrst@$txtgrn\H$txtrst:$txtylw\w$txtrst#$txtpur";;
  *) export PS1="$txtred\u$txtrst@$txtgrn\H$txtrst:$txtylw\w$txtrst#$txtpur";;
esac

## Bash script PROMPT_COMMAND before PS1
PROMPT_COMMAND="get_vcs_branch; $PROMPT_COMMAND"
case `id -u` in
  0) export PS1="$bldpur\u$bldcyn@$bldgrn\h$bldcyn:$bldblu\w$bldcyn->$txtrst($bldpur\$branch$txtrst$txtrst)\$";;
  *) export PS1="$bldpur\u$bldcyn@$bldgrn\h$bldcyn:$bldblu\w$bldcyn->$txtrst($bldpur\$branch$txtrst$txtrst)>";;
esac

