#sudo pacman -S inotify-tools

set -ex

repo_path=$HOME/services
repo_url=https://github.com/avagordon01/cluster-lab
hostname=$(hostname)
class=${hostname%-*} # drop everything after the last dash
unit_path=/usr/local/lib/systemd/system

if [ ! -d ${repo_path} ]; then
    mkdir -p ${repo_path}
    pushd ${repo_path}
    git clone ${repo_url}
    popd
fi

pushd ${repo_path}
while true; do
    date
    git fetch
    git reset --hard origin/main
    rm -rf ${unit_path}
    cp -r ${class} ${unit_path}
    systemctl daemon-reload
    sleep 30
done
popd
