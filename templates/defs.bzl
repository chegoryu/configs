def template_source(name, src, out, cursor_content = "", check_cmd = ""):
    """Generates a source file from a template by resolving template.nvim markers."""
    stem = out.split("/")[-1].split(".")[0]
    cmd = """
sed -e '/^#;; /d' -e 's|{{{{_cursor_}}}}|{cursor}|g' -e 's|{{{{_file_name_}}}}|{stem}|g' $< > $@
if grep -q '{{{{_' $@; then
    echo "Unresolved template markers in {out}:" >&2
    grep -n '{{{{_' $@ >&2
    exit 1
fi
""".format(cursor = cursor_content, stem = stem, out = out)
    if check_cmd:
        cmd += check_cmd + " $@\n"
    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = cmd,
    )
