set -o vi

gocoverweb () {
	t="/tmp/go-cover.$$.tmp"
	go test -coverprofile=$t $@ && \
	go tool cover -html=$t && \
    rm $t
}

function gocoverterminal() {
    echo "Testing..."
    w="cloud.crg.eti.br"       # dominio servidor web
    f="cover-$$.html"          # arquivo cover html
    t="/tmp/go-cover.$$.tmp"
    root=~/web/root            # root do servidor web
    go test ./... -coverprofile=$t && \
        go tool cover -html=$t -o $root/$f && \ 
        rm -f $t || \
        return 1
    echo "Open https://$w/$f"
    echo "Press enter to stop"
    read
    rm -f $root/$f
}

bindkey -s '^t^w' 'gocoverweb\n'
bindkey -s '^t^t' 'gocoverterminal\n'
