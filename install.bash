# Install VIM plugins
mkdir -p "$HOME/.vim/bundle"
for url in https://github.com/tpope/vim-pathogen https://github.com/ciaranm/inkpot git://repo.or.cz/vcscommand; do
  _url_base=$(basename $url)
  [ ! -d "$HOME/.vim/bundle/$_url_base" ] && git clone $url "$HOME/.vim/bundle/$_url_base"
done

if [ -z "$BASH_SOURCE" ]; then
  echo "Unable to determine location of install script!"
else
  _repo="$(cd $(dirname $BASH_SOURCE) && pwd -P)"
  _repo_home_rel="${_repo#$HOME/}"
  if [ "${_repo_home_rel:0:1}" = "/" ]; then
    _repo_home="$_repo_home_rel"
  else
    _repo_home="\$HOME/${_repo_home_rel}"
  fi
  if ! grep -qF "source \"$_repo_home/bashrc\"" "$HOME/.bashrc"; then
    echo "" >> "$HOME/.bashrc"
    echo "[ -e \"$_repo_home/bashrc\" ] && source \"$_repo_home/bashrc\"" >> "$HOME/.bashrc"
  fi
  [ ! -e "$HOME/.inputrc" ] && ln -s "$_repo/inputrc" "$HOME/.inputrc"
  [ ! -e "$HOME/.bash_aliases" ] && ln -s "$_repo/bash_aliases" "$HOME/.bash_aliases"
  [ ! -e "$HOME/.vimrc" ] && ln -s "$_repo/vimrc" "$HOME/.vimrc"
  [ ! -e "$HOME/.toprc" ] && ln -s "$_repo/toprc" "$HOME/.toprc"
fi

# vim:ts=2:sw=2:et
