$install_dir='C:\\Program Files (x86)\\Vim\\vim82\\'

tar -C ./rename2.vim/ --exclude='bin' --exclude='readme' --exclude='vimrc' -cf tmp.tar '.' 
tar -C $install_dir -xf tmp.tar
del tmp.tar

tar -C ./rename2.vim/bin -cf tmp.tar '.' 
tar -C $install_dir -xf tmp.tar
del tmp.tar

tar -C ./bin.win -cf tmp.tar '.' 
tar -C $install_dir -xf tmp.tar
del tmp.tar

cat ./rename2.vim/_vimrc > "$install_dir\..\_vimrc"

$env:Path = "$install_dir;$env:Path"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)