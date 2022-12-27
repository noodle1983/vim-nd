#!/usr/bin/perl

my $GIT_EXE="/usr/bin/git";

my $argc = scalar @ARGV;
my $git_cmd = $ARGV[0];

# git clone
if ($git_cmd eq "clone") {
    my $url = "";
    my $local_dir = "";
    my $recursive = 0;
    for(my $i = 1; $i < $argc; $i++) {
        my $option = $ARGV[$i];
	if ($option =~ m/^--recurs/) {
            $recursive = 1;
	}else{
            die "not support option:$option. ignore!" if $option =~ m/^-/; 
        }

        if (not $url){
            $url = $option;
        }else{
            $local_dir = $option;
        }
    }
    if (not $local_dir){
        $local_dir = $url;
        $local_dir =~ s/\/$//;
        $local_dir =~ s/\.git$//;
        $local_dir =~ s/^.*\///;
    }
    die "can't get local dir, url:$url\n" unless $local_dir; 
    mkdir($local_dir);

    die "can't cd to dir:$local_dir\n" unless chdir($local_dir); 
    if (not -d ".git"){
        system("$GIT_EXE init .");
    }

    system("$GIT_EXE remote add origin $url 2>/dev/null");
    run_until_success("$GIT_EXE fetch origin");
    run_until_success("$GIT_EXE remote set-head origin --auto");

    my $def_branch_name = `$GIT_EXE symbolic-ref refs/remotes/origin/HEAD 2>/dev/null`;
    $def_branch_name =~ s/^.*\///g;
    die "can't get default branch name!" unless $def_branch_name;
    system("$GIT_EXE checkout -f $def_branch_name");
    if ($recursive) {
        run_until_success("$GIT_EXE submodule update --init --recursive");
        run_until_success("$GIT_EXE submodule update --recursive");
    }
    
}else{
    my $command = "$GIT_EXE";
    for(my $i = 0; $i < $argc; $i++) {
        my $option = $ARGV[$i];
        
        if ($option =~ m/ /){
            $command .= " \"$option\"";
        }
        else{
            $command .= " $option";
        }

    }
    if ($git_cmd eq "checkout") {
        system($command);
    }else{
        run_until_success($command);
    }
}

sub run_until_success
{
    my $command = shift or die "no command provided!";

    my $retry = 0;
    my $ret = -1;
    while($ret != 0){
        if ($retry){
            print "ret: $ret, retry $retry, run_until_success: $command\n";
        }
        $ret = system("$command\n");
        if ($ret != 0){
            sleep(1);
            $retry++;
            next;
        }
        #if ($? == -1) {
        #    print "\tfailed to execute: $command\n";
        #    $ret = -1;
        #}
        #elsif ($? & 127) {
        #    my $signal = $? & 127;
        #    printf "\t[$command]child died with signal %d, %s coredump\n",
        #        $signal,  ($? & 128) ? 'with' : 'without';
        #    die "\tuser canceled!" if $signal == 2;
        #    $ret = -1;
        #}
        #else {
        #    $ret = $? >> 8;
        #    printf "\t[$command]exited with value %d\n", $ret;
        #}
        
        break;
    }

}


