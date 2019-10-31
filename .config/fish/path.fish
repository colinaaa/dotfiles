set -l PA ""
set --export GOPATH $HOME/go
set -l paths "
# yarn binary
$HOME/.yarn/bin
$HOME/.config/yarn/global/node_modules/.bin
$GOPATH/bin
"

for entry in (string split \n $paths)
    # resolve the {$HOME} substitutions
    set -l resolved_path (eval echo $entry)
    if test -d "$resolved_path";
        set PA $PA "$resolved_path"
    end
end

set --export PATH $PATH $PA
