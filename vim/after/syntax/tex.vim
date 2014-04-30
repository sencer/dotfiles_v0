syn region  texDiffAddStyle       matchgroup=texTypeStyle start="\\DIFaddbegin\(FL\)\?\s*" end="\s*\\DIFaddend\(FL\)\?" concealends contains=@texDiffGroup
syn region  texDiffDelStyle       matchgroup=texTypeStyle start="\\DIFdelbegin\(FL\)\?\s*" end="\s*\\DIFdelend\(FL\)\?" concealends contains=@texDiffGroup
syn region  texDiffInStyle        matchgroup=texTypeStyle start="\\DIF\(add\|del\)\(FL\)\?{"   skip="{\_.\{-}}" end="}" concealends transparent
syn region  texDiffInCmd          matchgroup=texTypeStyle start="%DIF\(DEL\|AUX\)CMD\s\?<\?\s\?" end="%%%\|%DIFAUXCMD"  concealends transparent keepend

syn cluster texDiffGroup          contains=texDiffInStyle,texDiffInCmd
syn cluster texFoldGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texBoldGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texItalGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texRefGroup           add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texMathZones          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texDocGroup           add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texPartGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texChapterGroup       add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSectionGroup       add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSubSectionGroup    add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSubSubSectionGroup add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texParaGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd

hi link texDiffAddStyle Underlined
hi link texDiffDelStyle Error
