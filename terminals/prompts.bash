#!/bin/bash
# Style 0
PS1_0='\033[32m$USER\033[0m@\033[32m$NAME \033[33m`echo $PWD | tr / "\\n" | tail -n 1`\033[36m`[ -d .git ] && echo -ne \ \(&& echo -n $(git branch --show-current) && echo -ne \)`\[\033[0m\]\n$ '
# Style 1
PS1_1='\033[32m┌──(\033[34m$USER\033[32m)-[\033[34m`echo $PWD | tr / "\\n" | tail -n 1``[ $(is_git_branch) == "0" ] && echo -ne "\033[0m -> \033[34m" && git branch --show-current`\033[32m]\n└─\033[34m$ \033[0m'
# Style 2
PS1_2='\033[32m$USER\033[0m@$NAME \033[32m`echo $PWD | grep -o /. | tr -d "\\012"``echo $PWD | tr / "\\n" | tail -n 1 | cut -c 2-`\033[0m`get_branch`\[\033[0m\]\n$ '

PS1_Count=3

# region Helper functions
is_git_branch() {
  num_dirs=`pwd | grep -o / | tr -d \\n | wc -c`
  cur_dir=`pwd`
  res=1
  for ((i = 0; i < $num_dirs; i++)) do
    if [[ -d "$cur_dir/.git" ]]; then
      res=0
      break
    else
      cur_dir="$cur_dir/.."
    fi
  done
  echo $res
}

get_branch() {
  num_dirs=`pwd | grep -o / | tr -d \\n | wc -c`
  cur_dir=`pwd`
  for ((i = 0; i < $num_dirs; i++)) do
    if [[ -d "$cur_dir/.git" ]]; then
      echo -ne \ \(
      echo -n `git branch --show-current`
      echo -ne \)
      break
    else
      cur_dir="$cur_dir/.."
    fi
  done
}

# endregion

# update_prompt() {
#   export status=$?
#   echo -ne "\`export status=\$?\`"'\033[32m$USER\033[0m@$NAME \033[33m`echo $PWD | tr / "\\n" | tail -n 1 | cut -b 2-`\033[36m`[ -d .git ] && echo -ne \ \(&& echo -n $(git branch --show-current) && echo -ne \)``[ $status > 0 ] && echo -e "\033[31m [$status] "\033[0m`\033[0m\n$ '
# }

