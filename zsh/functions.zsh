TODO_COLOR="red"
INFO_COLOR="blue"

alias_cc(){
    if [[ $(uname) = "Darwin" ]]; then
        alias 'cc'='/bin/cat'
    else
        alias 'cc'='/usr/bin/cat'
    fi
}

cd_start(){
    if [ -z $1 ]; then
       cc ~/.start_dir 
       return 0
    fi
    if [[ "$1" == "delete" ]]; then
        rm -f ~/.start_dir
        return 0
    fi
    echo $1 > ~/.start_dir
    return 0
}
# tmux handler on start
tm(){
    # Dont execuate if we are already in a tmux session.
    if [ $TERM_PROGRAM = "tmux" ]; then
        return 0
    fi

    # Dont execute if we are on a cpair
    if ! [ -z $CPAIR ]; then
        return 0
    fi

    sess=$(tmux ls | grep local)
    if [ -z "$sess" ]; then
        tmux new-session -s local -n localwindow
    else
        tmux attach-session -t local
    fi
}

s(){
    # alias s="cwd=$(pwd) && source ~/.zshrc; cd $cwd"
    echo "$(pwd)" > ~/.lastpath
    source ~/.zshrc
    cd "$(cat ~/.lastpath)"
}

ref(){
    if [ -z $1 ]; then
        cat ~/reference/*
    fi
    cat ~/reference/* | grep -i "$1"

}

todo(){
    local todo_file="$HOME/zsh/todo.zsh"
    if [[ $1 == "add" ]]; then
        echo "print -P "\"%F{$TODO_COLOR}TODO: %f$2 \""" >> $todo_file
    elif [[ $1 == "list" ]]; then
         $SHELL $todo_file 
    elif [[ $1 == "remove" ]]; then
        echo "removing: $(grep $2 $todo_file)"
        read -q "ans?Remove:Yy|Nn?"
        case $ans in
            [Yy]* ) sed -i '' "/$2/d" $todo_file;;
            [Nn]* ) echo "not removed";;
            * ) echo "Please answer yes or no.";;
        esac
    else
         $SHELL $todo_file | grep "$1" 
    fi
}

info(){
    local info_file="$HOME/zsh/info.zsh"
    if [[ $1 == "add" ]]; then
        echo "print -P "\"%F{$INFO_COLOR}INFO: %f$2 \""" >> $info_file
    elif [[ $1 == "list" ]]; then
         $SHELL $info_file 
    elif [[ $1 == "remove" ]]; then
        echo "removing: $(grep $2 $info_file)"
        read -q "ans?Remove:Yy|Nn?"
        case $ans in
            [Yy]* ) sed -i '' "/$2/d" $info_file;;
            [Nn]* ) echo "not removed";;
            * ) echo "Please answer yes or no.";;
        esac
    else
         $SHELL $info_file | grep "$1"  
    fi
}
