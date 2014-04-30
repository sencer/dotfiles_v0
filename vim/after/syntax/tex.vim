syn match texTypeStyle		"\\DIFaddbegin\>"
syn match texTypeStyle		"\\DIFdelbegin\>"
syn region texDiffAddStyle	matchgroup=texTypeStyle start="\\DIFaddbegin\(FL\)\?\s*\(\\DIFadd\(FL\)\?{\)\?" end="}\?\s*\\DIFaddend\(FL\)\?\s*" concealends
syn region texDiffDelStyle	matchgroup=texTypeStyle start="\\DIFdelbegin\(FL\)\?\s*\(\\DIFdel\(FL\)\?{\)\?" end="}\?\s*\\DIFdelend\(FL\)\?\s*" concealends
syn cluster texFoldGroup	add=texDiffAddStyle,texDiffDelStyle
" contains=@texDiffGroup
" syn cluster texDiffGroup	contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMatcher,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texBoldStyle,texBoldItalStyle,texNoSpell,texDiffStyle
" do the clustering -bold, italic bothways. and others
hi link texDiffAddStyle Underlined
hi link texDiffDelStyle Error
