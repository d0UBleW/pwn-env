import splitmind
(splitmind.Mind()
 .tell_splitter(show_titles=True)
 .tell_splitter(set_title="Main")
 .right(of="main", display="legend", size="50%")
 .show("regs", on="legend")
 .below(of="regs", display="stack", size="40%")
 .above(of="main", display="disasm", size="80%")
 .show("code", on="disasm", banner="none")
 .above(of="disasm", display="backtrace", size="30%")
 ).build(nobanner=True)
