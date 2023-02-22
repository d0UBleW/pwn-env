import splitmind
(splitmind.Mind()
 .tell_splitter(show_titles=True)
 .tell_splitter(set_title="Main")
 .right(of="main", display="legend", size="50%")
 .show("regs", on="legend")
 .below(of="regs", size="33%", clearing=False,
        cmd='echo "tty $(tty)" > /var/tmp/gdb_io_tty; tail -f /dev/null')
 .tell_splitter(set_title='Input / Output')
 .below(of="regs", display="stack", size="33%")
 .above(of="main", cmd="ipython3 --no-banner", size="25%")
 .tell_splitter(set_title='IPython3')
 .above(of="main", display="disasm", size="70%")
 .show("code", on="disasm", banner="none")
 .below(of="disasm", display="backtrace", size="25%")
 ).build(nobanner=True)
