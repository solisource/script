if exists("b:verilog_plugin")
   finish
endif
let b:verilog_plugin = 1

iabbrev <= <= #1

command Aheader :call  AddHeader()
command Allpn :call AddAlways("posedge","negedge")
command Allcom :call AddAlways("", "")
command Acontent :call  AddContent()


"===============================================================
"        Add File Header
"===============================================================
function AddHeader()
  call append(0,  "//================================================================================")
  call append(1,  "// Created by         : Smart System Master.Jin")
  call append(2,  "// Filename           : ".expand("%"))
  call append(3,  "// Author             : Master.Jin")
  call append(4,  "// Created On         : ".strftime("%Y-%m-%d %H:%M"))
  call append(5,  "// Last Modified      :  ")
  call append(6,  "// Update Count       : ".strftime("%Y-%m-%d %H:%M"))
  call append(7,  "// Description        : ")
  call append(8,  "//                      ")
  call append(9,  "//                      ")
  call append(10, "//================================================================================")
endfunction
"===============================================================
"
"===============================================================
function AddContent()
  let curr_line = line(".")
  call append(curr_line,   "//================================================================================")
  call append(curr_line+1, "//Function  : ")
  "call append(curr_line+2, "//            ")
  call append(curr_line+2, "//Arguments : ")
  "call append(curr_line+4, "//            ")
  call append(curr_line+3, "//================================================================================")
endfunction
"===============================================================
"        Add an always statement
"===============================================================
function AddAlways(clk_edge, rst_edge)
   "for line in getline(1, line("$"))
   "   if line =~ '^\s*\<input\>.*//\s*\<clock\>\s*$'
   "      let line = substitute(line, '^\s*\<input\>\s*', "", "")
   "      let clk_edge = substitute(line, '\s*;.*$', "", "")
   "   elseif line =~ '^\s*\<input\>.*//\s*\<reset\>\s*$'
   "      let line = substitute(line, '^\s*\<input\>\s*', "", "")
   "      let rst_edge = substitute(line, '\s*;.*$', "", "")
   "   elseif line =~ '^\s*\<reg\>.*//\s*\<clock\>\s*$'
   "      let line = substitute(line, '^\s*\<reg\>\s*', "", "")
   "      let clk_edge = substitute(line, '\s*;.*$', "", "")
   "   elseif line =~ '^\s*\<reg\>.*//\s*\<reset\>\s*$'
   "      let line = substitute(line, '^\s*\<reg\>\s*', "", "")
   "      let rst_edge = substitute(line, '\s*;.*$', "", "")
   "   endif
   "endfor
   let curr_line = line(".")
   if a:clk_edge == "posedge" && a:rst_edge == "posedge"
      call append(curr_line,   "always @(posedge ".clk." or posedge ".rst.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "  if (".rst.") begin")
      call append(curr_line+3, "  end")
      call append(curr_line+4, "  else begin")
      call append(curr_line+5, "  end")
      call append(curr_line+6, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == "posedge"
      call append(curr_line,   "always @(negedge ".clk." or posedge ".rst.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "  if (".rst.") begin")
      call append(curr_line+3, "  end")
      call append(curr_line+4, "  else begin")
      call append(curr_line+5, "  end")
      call append(curr_line+6, "end")
   elseif a:clk_edge == "posedge" && a:rst_edge == "negedge"
      call append(curr_line,   "always @(posedge ".clk." or negedge ".rst.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "  if (!".rst.") begin")
      call append(curr_line+3, "  end")
      call append(curr_line+4, "  else begin")
      call append(curr_line+5, "  end")
      call append(curr_line+6, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == "negedge"
      call append(curr_line,   "always @(negedge ".clk." or negedge ".rst.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "  if (!".rst.") begin")
      call append(curr_line+3, "  end")
      call append(curr_line+4, "  else begin")
      call append(curr_line+5, "  end")
      call append(curr_line+6, "end")
   elseif a:clk_edge == "posedge" && a:rst_edge == ""
      call append(curr_line,   "always @(posedge ".clk.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "end")
   elseif a:clk_edge == "negedge" && a:rst_edge == ""
      call append(curr_line,   "always @(negedge ".clk.")")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "end")
   else
      call append(curr_line,   "always @(*)")
      call append(curr_line+1, "begin")
      call append(curr_line+2, "end")
   endif
endfunction


"autocmd BufWritePre,FileWritePre *.v   ks|call LastModified()|'s
fun LastModified()
    let l = line("$")
    exe "1," . l . "g/Last Modified      :/s/Last Modified      :.*/Last Modified      : " .
        \ strftime("%Y-%m-%d %H:%M")
endfun

"Hot key mapping
:inoremap    <A-a>  <ESC>:Allpn<CR>
map          <A-a>  :Allpn<CR>
:inoremap    <A-c>  <ESC>:Allcom<CR>
map          <A-c>  :Allcom<CR>
:inoremap    <A-z>  <ESC>:Aheader<CR>
map          <A-z>  :Aheader<CR>
:inoremap    <A-l>  <ESC>:Acontent<CR>
map          <A-l>  :Acontent<CR>

"就是按下保存会自动修改Last Modifited的时间
autocmd BufWritePre,FileWritePre *.v   ks|call LastModified()|'s
