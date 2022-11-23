#!/bin/bash

uv() {
  sed -i "s/version>[0-9]\.[0-9]\.[0-9]/version>$1/" **/package.xml \
    && git commit -am "Update package.xml versions to $1." \
    && git push
}

gtl() {
  git tag --list | sort -Vr
}

pv() {
  rg  'version>' -g package.xml
}

gcm() {
  git commit -am "Update package.xml versions to $1." \
    && git push
}

# Colcon build everything with continue-on-error, limited threads/workers, and RelWithDebInfo.
# MAKEFLAGS and --parallel-workers limits our threads/workers.
# --continue-on-error I've found is always desirable. Without it, colcon stops at first failed package.
# RelWithDebInfo needs to be there, otherwise you run into performance issues after deploying to vehicle.
# \param $1 = thread number (optional)
cbc() {
  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

# Colcon build a specific package and its dependencies with continue-on-error, limited threads/workers, and RelWithDebInfo.
# MAKEFLAGS and --parallel-workers limits our threads/workers.
# --continue-on-error I've found is always desirable. Without it, colcon stops at first failed package.
# RelWithDebInfo needs to be there, otherwise you run into performance issues after deploying to vehicle.
cbp() {
  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --packages-up-to $1 \
    --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

cbps() {
  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --packages-select $1 \
    --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

ctp() {
  colcon test --return-code-on-test-failure --retest-until-fail 2 --packages-select $1
}

# Colcon build a specific package and its dependencies with continue-on-error, limited threads/workers,
# RelWithDebInfo, and flags set up for testing.
# MAKEFLAGS and --parallel-workers limits our threads/workers.
# --continue-on-error I've found is always desirable. Without it, colcon stops at first failed package.
# RelWithDebInfo needs to be there, otherwise you run into performance issues after deploying to vehicle.
# \param $1 = name of package or thread number
# \param $2 = name of package when $1 has thread number
cbpt() {
  how="packages-up-to"
  if [[ $1 = "s" ]]; then
    how="packages-select"
  fi

  package="$1"
  if [[ -n $2 ]]; then
    package="$2"
  fi

  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --$how $package\
    --cmake-args \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    && ctp $package
}

cbpts() {
  package="$1"

  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 --packages-select $package\
    --cmake-args \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

# Colcon build all packages with testing flags.
cta() {
  MAKEFLAGS="-j8 -l8" colcon build --continue-on-error --parallel-workers 8 \
    --cmake-args \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_CXX_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_C_FLAGS='-fprofile-arcs -ftest-coverage --coverage' \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

# Colcon build all packages with testing flags and then run the tests.
ctt() {
  cta
  colcon test --return-code-on-test-failure --retest-until-fail 2
}

# colcon test-result with package name passing
ctr() {
  rest=""
  if [[ -n $1 ]]; then
    rest="--test-result-base ./build/$1"
  fi
  colcon test-result $rest
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
