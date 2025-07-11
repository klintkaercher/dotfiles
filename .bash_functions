#!/bin/bash

# Either `git status` if no arg, or tries jj
gs() {
  if [[ -z "$1" ]]; then
    git status
  elif [[ "$1" -eq "-c" ]] && [[ -n $2 ]]; then
    git switch -c "$2"
  elif [[ $(git tag --list) =~ "$1" ]]; then
      git switch -d "$1"
  elif ! git switch "$1"; then
    echo "BRANCH $1 DOESN'T EXIST."
  fi
}
_gs_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    if [[ $COMP_CWORD -ge 2 ]]; then
        COMPREPLY=()
    else
        local branches=$(git branch -r 2> /dev/null | sd "origin/HEAD.*" "" | sd "origin/" "")
        COMPREPLY=($(compgen -W "$branches $COMP_CWORD" -- "$cur"))
    fi
}

complete -F _gs_completion gs

# Git commit with either a commit string or squash it into the previous commit.
gco() {
  if [[ -n $1 ]]; then
    git commit -am "$1"
  else
    git commit -a --amend --no-edit --date=now
  fi
}

# Git commit with either a commit string or squash it into the previous commit.
gca() {
  if [[ -n $1 ]]; then
    git commit --amend --message "$1"
  else
    git commit --amend
  fi
}

# This function will just dump a bunch of html files into the current directory.
# `gcov_run <PACKAGE_ROOT> <PACKAGE_NAME>`
# Ex.
# `gcov_run src/general/rtk_common/rtk_ros_utils rtk_ros_utils`
gcov_run() {
  gcovr -j 8 -r $1 build/$2 install/ --html-details --html-medium-threshold 60 --html-high-threshold 80 -o $2.html
}

# Colcon build everything with continue-on-error, limited threads/workers, and RelWithDebInfo.
# MAKEFLAGS and --parallel-workers limits our threads/workers.
# --continue-on-error I've found is always desirable. Without it, colcon stops at first failed package.
# RelWithDebInfo needs to be there, otherwise you run into performance issues after deploying to vehicle.
cbc4() {
  if [[ -z $1 ]]; then
    MAKEFLAGS="-j4 -l4" colcon build --continue-on-error --parallel-workers 4 --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    return 0
  fi

  local how=""
  local package=""
  local test=0

  if [[ $1 = "s" ]] || [[ $1 = "select" ]] || [[ $2 = "s" ]] || [[ $2 = "select" ]]; then
    how="--packages-select"
  fi

  if [[ $1 = "t" ]] || [[ $1 = "test" ]] || [[ $2 = "t" ]] || [[ $2 = "test" ]]; then
    test=1
  fi

  if [[ -n $3 ]]; then
    package="$3"
  fi

  if [[ -z $how ]] && [[ $test -eq 0 ]] && [[ -n $1 ]]; then
    package="$1"
    how="--packages-up-to"
  fi

  if [[ -z $how ]] && [[ $test -eq 1 ]] && [[ -n $2 ]]; then
    package="$2"
    how="--packages-up-to"
  fi

  if [[ -n $how ]] && [[ $test -eq 0 ]] && [[ -n $2 ]]; then
    package="$2"
  fi

  if [[ $test -eq 0 ]] && [[ -n $package ]]; then
    MAKEFLAGS="-j4 -l4" colcon build --continue-on-error --parallel-workers 4 $how $package \
      --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  elif [[ $test -eq 1 ]] && [[ -z $package ]]; then
    # cta
    MAKEFLAGS="-j4 -l4" colcon build --continue-on-error --parallel-workers 4 \
      --cmake-args \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  elif [[ $test -eq 1 ]] && [[ -n $package ]]; then
    # cta
    MAKEFLAGS="-j4 -l4" colcon build --continue-on-error --parallel-workers 4  $how $package \
      --cmake-args \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  fi
}

export -f cbc4

# Colcon build everything with continue-on-error, limited threads/workers, and RelWithDebInfo.
# MAKEFLAGS and --parallel-workers limits our threads/workers.
# --continue-on-error I've found is always desirable. Without it, colcon stops at first failed package.
# RelWithDebInfo needs to be there, otherwise you run into performance issues after deploying to vehicle.
cbc() {
  if [[ -z $1 ]]; then
    MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    return 0
  fi

  local how=""
  local package=""
  local test=0

  if [[ $1 = "s" ]] || [[ $1 = "select" ]] || [[ $2 = "s" ]] || [[ $2 = "select" ]]; then
    how="--packages-select"
  fi

  if [[ $1 = "t" ]] || [[ $1 = "test" ]] || [[ $2 = "t" ]] || [[ $2 = "test" ]]; then
    test=1
  fi

  if [[ -n $3 ]]; then
    package="$3"
  fi

  if [[ -z $how ]] && [[ $test -eq 0 ]] && [[ -n $1 ]]; then
    package="$1"
    how="--packages-up-to"
  fi

  if [[ -z $how ]] && [[ $test -eq 1 ]] && [[ -n $2 ]]; then
    package="$2"
    how="--packages-up-to"
  fi

  if [[ -n $how ]] && [[ $test -eq 0 ]] && [[ -n $2 ]]; then
    package="$2"
  fi

  if [[ $test -eq 0 ]] && [[ -n $package ]]; then
    MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 $how $package \
      --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  elif [[ $test -eq 1 ]] && [[ -z $package ]]; then
    # cta
    MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 \
      --cmake-args \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  elif [[ $test -eq 1 ]] && [[ -n $package ]]; then
    # cta
    MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8  $how $package \
      --cmake-args \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1
  fi
}

export -f cbc

# This is the function you want to use and it's usage is just `ct <PACKAGE_NAME>`.
ct() {
  if [[ $1 = "r" ]]; then
    if [[ -n $2 ]]; then
      colcon test-result --test-result-base ./build/$2
    else
      colcon test-result --test-result-base ./build
    fi
    return 0
  fi

  if [[ -n $1 ]]; then
    colcon test --return-code-on-test-failure --retest-until-fail 2 --packages-select $1
    colcon test-result --test-result-base ./build/$1
  else
    colcon test --return-code-on-test-failure --retest-until-fail 2
    colcon test-result --test-result-base ./build
  fi
}

# Attach to a docker container, but with a new process.
# \param $1 name of the container
# \return 0 if good, 1 if no param
de() {
  if [[ -n $1 ]];
  then
    docker exec -it $1 /bin/bash
  else
    echo "Need container name."
    return 1
  fi
  return 0
}

# Search branches and checkout the first matching pattern branch
# \param $1
# \return 0 if good, 1 if no param, 2 if no branch match
gcn() {
  if [[ -z $1 ]]
  then
    echo "Need a pattern to match."
    return 1
  fi

  i=$(git branch -a | sed 's@  remotes/origin/@@' | grep "$1" | head -n 1)
  if [[ -n $i ]]
  then
    git checkout $i
    return 0
  else
    echo "No branch found matching \"$1\""
    return 2
  fi
}
