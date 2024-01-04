git_clone_or_pull() {
    if [[ "$#" -ne 2 ]]; then
        echo "Usage: git_clone_or_pull <repo> <dir>"
        return
    fi

    if [[ -d "$2" ]]; then
        git -C "$2" pull
    else
        git clone "$1" "$2"
    fi
}
